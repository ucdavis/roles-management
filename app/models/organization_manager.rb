class OrganizationManager < ActiveRecord::Base
  belongs_to :organization, :touch => true
  belongs_to :manager, :class_name => 'Entity', :touch => true

  validates_presence_of :organization_id, :manager_id
  validates_uniqueness_of :manager_id, :scope => [:organization_id]

  validate :manager_entity_is_a_person

  private

  def manager_entity_is_a_person
    if manager.type != 'Person'
      errors[:base] << "Organization manager must be a Person"
    end
  end
end
