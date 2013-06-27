class Entity < ActiveRecord::Base
  using_access_control

  # We need to be able to assign :type when creating an entity using the Entity super-class
  def self.attributes_protected_by_default
    # default is ["id","type"]
    ["id"]
  end
end
