class RoleAssignment < ApplicationRecord
  include Immutable

  belongs_to :role, touch: true
  belongs_to :entity, touch: true

  validates :role, :entity, presence: true
  validate :parent_must_exist_if_set
  validate :parent_not_allowed_for_groups

  private

  def parent_must_exist_if_set
    return unless parent_id && RoleAssignment.find_by_id(parent_id).nil?

    errors.add(:parent_id, 'RoleAssignment with id == parent_id must exist')
    return false # rubocop:disable Style/RedundantReturn
  end

  # Groups are not allowed to inherit roles
  def parent_not_allowed_for_groups
    return unless parent_id && entity.type == 'Group'

    errors.add(:parent_id, 'parent_id cannot be set if entity is a Group')
    return false # rubocop:disable Style/RedundantReturn
  end
end
