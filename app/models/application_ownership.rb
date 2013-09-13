class ApplicationOwnership < ActiveRecord::Base
  using_access_control

  belongs_to :application, :touch => true
  belongs_to :entity, :touch => true
  
  validates_uniqueness_of :application_id, :scope => [:entity_id, :parent_id]
  
  before_destroy :require_destroy_flag
  
  after_create :grant_ownership_to_group_members
  before_destroy :remove_ownership_from_group_members
  
  private
  
  # Grant this application ownership to all members of the group
  # (iff group ownership is with a group)
  def grant_ownership_to_group_members
    if entity.type == 'Group'
      Rails.logger.tagged "ApplicationOwnership #{id}" do
        entity.members.each do |m|
          logger.info "Granting application ownership (#{id}, #{application.name}) granted to group (#{entity.id}/#{entity.name}) to its member (#{m.id}/#{m.name})"
          ao = ApplicationOwnership.new
          ao.application_id = application_id
          ao.entity_id = m.id
          ao.parent_id = entity.id
          if ao.save == false
            logger.error "  -- Failed to grant application ownership!"
          end
        end
      end
    end
  end

  # Remove this application ownership from all members of the group
  # (iff group ownership is with a group)  
  def remove_ownership_from_group_members
    if entity.type == 'Group'
      Rails.logger.tagged "ApplicationOwnership #{id}" do
        entity.members.each do |m|
          logger.info "Removing application ownership (#{id}, #{application.name}) about to be removed from group (#{entity.id}/#{entity.name} from its member #{m.id}/#{m.name})"
          ao = ApplicationOwnership.find_by_application_id_and_entity_id_and_parent_id(application_id, m.id, entity.id)
          if ao
            destroying_calculated_application_ownership do
              ao.destroy
            end
          else
            logger.warn "Failed to remove application ownership (#{id}, #{application.name}) assigned to group member (#{m.id}/#{m.name}) which needs to be removed as the group (#{entity.id}/#{entity.name}) is losing that ownership."
          end
        end
      end
    end
  end
  
  # This flag is required to destroy any application operatorship which has a parent operatorship.
  # The purpose of this flagging mechanism is to ensure an ApplicationOperatorship is only destroyed
  # in the right ways, e.g. triggering the grant/remove callbacks found in this class.
  def require_destroy_flag
    if parent_id and not Thread.current[:application_ownership_destroy_flag]
      errors.add(:parent_id, "can't destroy a calculated group ownership without flag properly set")
      return false
    end
  end
end

def destroying_calculated_application_ownership
  begin
    Thread.current[:application_ownership_destroy_flag] = true
    yield
  ensure
    Thread.current[:application_ownership_destroy_flag] = nil
  end
end
