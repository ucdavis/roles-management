class GroupOperatorship < ApplicationRecord
  include Immutable

  validates_presence_of :group, :entity
  validate :group_cannot_operate_itself

  belongs_to :group, touch: true
  belongs_to :entity, touch: true

  before_destroy { |operatorship| operatorship.group.touch && operatorship.entity.touch } # workaround for Rails bug

  after_save { |operatorship| operatorship.log_changes(:save) }
  after_destroy { |operatorship| operatorship.log_changes(:destroy) }

  protected

  # Explicitly log that this group operatorship was created or destroyed
  def log_changes(action)
    Rails.logger.tagged "GroupOperatorship #{id}" do
      case action
      when :save
        if saved_change_to_attribute?(:created_at)
          logger.info "Created group operatorship between #{entity.log_identifier} and #{group.log_identifier}."
        else
          # GroupOperatorships should really only be created or destroyed, not updated.
          logger.error "log_changes called for existing GroupOperatorship. This shouldn't happen. Operatorship is between #{entity.log_identifier} and #{group.log_identifier}."
        end
      when :destroy
        logger.info "Removed group operatorship between #{entity.log_identifier} and #{group.log_identifier}."
      else
        logger.warn "Unknown action in log_changes #{action}."
      end
    end
  end

  private

  # Ensure a group does not attempt to operate itself
  def group_cannot_operate_itself
    if !group.blank? && group == entity
      errors[:base] << 'Group cannot operate itself'
    end
  end
end
