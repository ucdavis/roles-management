class ActivityLog
  LOG_LEVELS = { info: 0, warn: 1, err: 2 }.freeze

  def self.record!(message = nil, tags = [], level = :info)
    return if Rails.env.test?
    return if message.nil?

    tags.each do |tag|
      activity_logger = Logger.new(Rails.root.join('log', 'activity').to_s + '/' + tag)
      activity_logger.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end

      case level
      when :info
        log_level_str = 'INFO'
      when :warn
        log_level_str = 'WARN'
      when :err
        log_level_str = 'ERROR'
      else
        log_level_str = "UNKNOWN (#{level.to_s})"
      end

      activity_logger.info "#{Time.now} - #{log_level_str} - #{message}"
      Rails.logger.info "#{tag}: #{Time.now} - #{log_level_str} - #{message}"
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
end
