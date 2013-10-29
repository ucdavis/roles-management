class Application < ActiveRecord::Base
  using_access_control
  
  validates :name, :presence => true, :uniqueness => true
  
  has_many :roles, :dependent => :destroy
  has_many :application_ownerships, :dependent => :destroy
  has_many :owners, :through => :application_ownerships, :source => :entity
  has_many :operatorships, :dependent => :destroy, :class_name => "ApplicationOperatorship"
  has_many :operators, :through => :operatorships, :source => :entity
  
  has_attached_file :icon, :styles => { :normal => "75x75" }, :default_url => ""
  
  attr_accessible :name, :description, :roles_attributes, :owner_ids, :operatorships_attributes, :url, :icon
  
  accepts_nested_attributes_for :roles, :allow_destroy => true
  accepts_nested_attributes_for :operatorships, :allow_destroy => true
  
  # Note the nested 'role' JSON includes "members" and "entities."
  # 'members' are people only - flattened entities.
  # 'entities' are what actually exists in the database but includes groups.
  def as_json(options={})
    { :id => self.id, :name => self.name, url: self.url, icon: self.icon(:normal),
      :roles => self.roles.map{ |r| { id: r.id, description: r.description, token: r.token, name: r.name, ad_path: r.ad_path } },
      :description => self.description, :owners => self.application_ownerships.map{ |o| { name: o.entity.name, id: o.entity.id, calculated: o.parent_id? } },
      :operatorships => self.operatorships.includes(:entity).map{ |o| { name: o.entity.name, entity_id: o.entity.id, id: o.id, calculated: o.parent_id? } } }
  end
  
  def self.csv_header
    "Role,ID,Login ID,Email,First,Last".split(',')
  end
  
  def trigger_sync
    logger.info "Person #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync! }
  end
end
