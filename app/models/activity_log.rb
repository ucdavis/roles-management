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

      Rails.logger.info "ActivityLog: #{tag}: #{Time.now} - #{log_level_str} - #{message}"

      # Only write to DynamoDB if in production.
      # If you want to write in development, ensure development is using
      # production database, else logs could be written concerning the wrong entity IDs!
      if Rails.env.production?
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

  # Fetch activity for the given tag, e.g. "person_132", "group_312", "application_1"
  # Order by most recent or [] if none.
  def self.fetch(tag)
    params = {
      table_name: DynamoDbTable,
      key_condition_expression: '#LogEntityId = :id',
      expression_attribute_names: {
        '#LogEntityId' => 'LogEntityId'
      },
      expression_attribute_values: {
        ':id' => tag
      }
    }

    activity = []

    begin
      result = DynamoDbClient.query(params)

      result.items.each do |item|
        next if item['entry']['message'] == 'Logged in.'
        activity.push OpenStruct.new(
          performed_at: Time.at(item['entry']['logged_at'].to_f).to_datetime,
          message: item['entry']['message']
        )
      end
    rescue Aws::DynamoDB::Errors::ServiceError => error
      Rails.logger.error "Unable to fetch activity log from DynamoDB for #{tag}. Error:"
      Rails.logger.error error.message.to_s
    end

    # Return sorted with most recent first
    return activity.sort { |x, y| x[:performed_at] <=> y[:performed_at] }.reverse
  end
end
