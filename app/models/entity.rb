class Entity < ActiveRecord::Base
  using_access_control
  
  has_many :organization_entity_associations
  has_many :organizations, :through => :organization_entity_associations
  
  def person?
    type == 'Person'
  end

  def group?
    type == 'Group'
  end
  
  # We need to be able to assign :type when creating an entity using the Entity super-class
  def self.attributes_protected_by_default
    # default is ["id","type"]
    ["id"]
  end
end
