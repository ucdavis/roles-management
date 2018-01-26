class GroupOwnership < ApplicationRecord
  validates_presence_of :group, :entity
  validates_uniqueness_of :entity_id, scope: :group_id
  validate :group_cannot_own_itself

  belongs_to :group, touch: true
  belongs_to :entity, touch: true

  after_save { |ownership| ownership.log_changes(:save) }
  after_destroy { |ownership| ownership.log_changes(:destroy) }

  protected

  # Explicitly log that this group ownership was created or destroyed
  def log_changes(action)
    Rails.logger.tagged "GroupOwnership #{id}" do
      case action
      when :save
        if saved_change_to_attribute?(:created_at)
          logger.info "Created group ownership between #{entity.log_identifier} and #{group.log_identifier}."
        else
          # GroupOwnerships should really only be created or destroyed, not updated.
          logger.error "log_changes called for existing GroupOwnership. This shouldn't happen. Ownership is between #{entity.log_identifier} and #{group.log_identifier}."
        end
      when :destroy
        logger.info "Removed group ownership between #{entity.log_identifier} and #{group.log_identifier}."
      else
        logger.warn "Unknown action in log_changes #{action}."
      end
    end
  end

  private

  # Ensure a group does not attempt to own itself
  def group_cannot_own_itself
    if !group.blank? && group == entity
      errors[:base] << "Group (#{group.id}, #{group.name}) cannot own itself (#{entity.id}, #{entity.name})"
    end
  end
end
