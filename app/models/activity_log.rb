class ActivityLog
  require 'securerandom'

  LOG_LEVELS = { info: 'INFO', warn: 'WARN', err: 'ERROR' }.freeze

  def self.record!(message, tags, level = :info)
    return if Rails.env.test?
    return if message.nil?
    return if tags.nil?

    tags.each do |tag|
      log_level_str = LOG_LEVELS[level]
      log_level_str ||= "UNKNOWN (#{level})"

      Rails.logger.info "#{tag}: #{Time.now} - #{log_level_str} - #{message}"

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
