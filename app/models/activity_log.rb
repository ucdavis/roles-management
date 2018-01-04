class ActivityLog < ApplicationRecord
  LOG_LEVELS = { info: 0, warn: 1, err: 2 }.freeze

  validates_presence_of :message, :performed_at
  validates_inclusion_of :level, in: LOG_LEVELS.values

  has_many :activity_log_tag_associations
  has_many :activity_log_tags, through: :activity_log_tag_associations

  before_validation :set_performed_at_field

  def self.record!(message = nil, tags = [], level = :info)
    return if Rails.env.test?
    tags.each do |tag|
      activity_logger = Logger.new(Rails.root.join('log', 'activity').to_s + '/' + tag)
      activity_logger.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end
      log_level_str = 'INFO' if log.level == 0 # rubocop:disable Style/NumericPredicate
      log_level_str = 'WARN' if log.level == 1
      log_level_str = 'ERROR' if log.level == 2
      activity_logger.info "#{Time.now} - #{log_level_str} - #{message}"
      activity_logger.close
    end
  end

  def self.info!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :info)
  end

  def self.warn!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :warn)
  end

  def self.err!(message = nil, tags = [])
    ActivityLog.record!(message, tags, :err)
  end

  private

  def set_performed_at_field
    self.performed_at = Time.now unless performed_at
  end
end
