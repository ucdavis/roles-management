class Application < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :roles, :dependent => :destroy
  has_many :application_ownerships, :dependent => :destroy
  has_many :owners, :through => :application_ownerships, :source => :entity
  has_many :operatorships, :dependent => :destroy, :class_name => "ApplicationOperatorship"
  has_many :operators, :through => :operatorships, :source => :entity

  accepts_nested_attributes_for :roles, :allow_destroy => true
  accepts_nested_attributes_for :operatorships, :allow_destroy => true

  after_create  { |application|
    ActivityLog.info!("Created application #{application.name}.", ["application_#{application.id}"])
  }
  after_destroy { |application|
    ActivityLog.info!("Deleted application #{application.name}.", ["application_#{application.id}"])
  }

  # Note the nested 'role' JSON includes "members" and "entities."
  # 'members' are people only - flattened entities.
  # 'entities' are what actually exists in the database but includes groups.
  def as_json(options={})
    { :id => self.id, :name => self.name, url: self.url,
      :roles => self.roles.map{ |r| { id: r.id, description: r.description, token: r.token, name: r.name, ad_path: r.ad_path } },
      :description => self.description, :owners => self.application_ownerships.map{ |o| { name: o.entity.name, id: o.entity.id, calculated: o.parent_id? } },
      :operatorships => self.operatorships.includes(:entity).map{ |o| { name: o.entity.name, entity_id: o.entity.id, id: o.id, calculated: o.parent_id? } } }
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Application:#{id},#{name})"
  end

  def self.csv_header
    "Role,ID,Login ID,Email,First,Last".split(',')
  end

  # Retrieve ActivityLog for this application order by most recent. nil if none
  def activity
    tag = ActivityLogTag.find_by_tag("application_#{self.id}")
    return [] unless tag
    return tag.activity_logs.order('performed_at DESC')
  end
end
