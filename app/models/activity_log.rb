class ActivityLog < ActiveRecord::Base
  using_access_control

  LOG_LEVELS = { :info => 0, :warn => 1, :err => 2 }

  #attr_accessible :message, :performed_at, :level

  validates_presence_of :message, :performed_at
  validates_inclusion_of :level, :in => LOG_LEVELS.values()

  has_many :activity_log_tag_associations
  has_many :activity_log_tags, :through => :activity_log_tag_associations

  before_validation :set_performed_at_field

  def ActivityLog.record!(message = nil, tags = [], level = :info)
    al = ActivityLog.create!({message: message, level: LOG_LEVELS[level]})

    tags.each do |tag|
      alt = ActivityLogTag.find_or_create_by(tag: tag)
      al.activity_log_tags << alt
    end
  end

  def ActivityLog.info!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :info)
  end

  def ActivityLog.warn!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :warn)
  end

  def ActivityLog.err!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :err)
  end

  private

  def set_performed_at_field
    self.performed_at = Time.now unless self.performed_at
  end
end
