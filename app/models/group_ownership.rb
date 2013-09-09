class GroupOwnership < ActiveRecord::Base
  using_access_control

  validates_presence_of :group, :entity
  validates_uniqueness_of :entity_id, :scope => :group_id
  validate :group_cannot_own_itself

  belongs_to :group, :touch => true
  belongs_to :entity, :touch => true

  private

  # Ensure a group does not attempt to own itself
  def group_cannot_own_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot own itself"
    end
  end
end
