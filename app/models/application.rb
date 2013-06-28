class Application < ActiveRecord::Base
  using_access_control

  validates :name, :presence => true, :uniqueness => true

  has_many :roles, :dependent => :destroy
  has_many :application_ownerships, :dependent => :destroy
  has_many :owners, :through => :application_ownerships
  has_many :application_operatorships, :dependent => :destroy
  has_many :operators, :through => :application_operatorships, :source => "entity", :dependent => :destroy
  belongs_to :api_key

  attr_accessible :name, :description, :roles_attributes, :owner_ids, :operator_ids
  accepts_nested_attributes_for :roles, :allow_destroy => true

  # Note the nested 'role' JSON includes "members" and "entities."
  # 'members' are people only - flattened entities.
  # 'entities' are what actually exists in the database but includes groups.
  def as_json(options={})
    { :id => self.id, :name => self.name,
      :roles => self.roles.map{ |r| { id: r.id, description: r.description, token: r.token, name: r.name,
                                      assignments: r.role_assignments.map { |a| { id: a.id, calculated: a.calculated, entity_id: a.entity_id, name: a.entity.name } },
                                      entities: r.entities.map { |e| { id: e.id, name: e.name, type: e.type } },
                                      members: r.members.map { |m| { id: m.id, name: m.name, loginid: m.loginid } },
                                      ad_path: r.ad_path } },
      :description => self.description, :owners => self.owners.map{ |o| { name: o.name, id: o.id } },
      :operators => self.operators.map{ |o| { name: o.name, id: o.id } } }
  end

  def self.csv_header
    "Role,ID,Login ID,Email,First,Last".split(',')
  end
end
