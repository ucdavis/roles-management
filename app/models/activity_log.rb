class ActivityLog
  require 'securerandom'

  LOG_LEVELS = { info: 0, warn: 1, err: 2 }.freeze

  def self.record!(message, tags, level = :info)
    return if Rails.env.test?
    return if message.nil?

    tags.each do |tag|
      activity_logger = Logger.new(Rails.root.join('log', 'activity').to_s + '/' + tag)
      activity_logger.formatter = proc do |_severity, _datetime, _progname, msg|
        "#{msg}\n"
      end

      log_level_str = case level
                      when :info
                        'INFO'
                      when :warn
                        'WARN'
                      when :err
                        'ERROR'
                      else
                        "UNKNOWN (#{level})"
                      end

      activity_logger.info "#{Time.now} - #{log_level_str} - #{message}"
      Rails.logger.info "#{tag}: #{Time.now} - #{log_level_str} - #{message}"
      activity_logger.close

      begin
        DynamoDbClient.put_item(
          table_name: DynamoDbTable,
          item: {
            LogEntityId: tag,
            UUID: SecureRandom.uuid,
            entry: {
              logged_at: Time.now.to_f,
              level: log_level_str,
              message: message
            }
          }
        )
      rescue Aws::DynamoDB::Errors::ServiceError => error
        Rails.logger.error 'Unable to write to DynamoDB activity log:'
        Rails.logger.error error.message.to_s
      end
    end
  end

  def self.info!(message, tags)
    ActivityLog.record!(message, tags, :info)
  end

  def self.warn!(message, tags)
    ActivityLog.record!(message, tags, :warn)
  end

  def self.err!(message, tags)
    ActivityLog.record!(message, tags, :err)
  end
end
