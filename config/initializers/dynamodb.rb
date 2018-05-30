Aws.config.update({
  region: ENV['DYNAMODB_REGION'] || Rails.application.secrets[:dynamodb_region],
  credentials: Aws::Credentials.new(ENV['DYNAMODB_AWS_ACCESS_KEY'], ENV['DYNAMODB_AWS_SECRET_KEY'])
})

::DynamoDbClient = Aws::DynamoDB::Client.new
::DynamoDbTable = ENV['DYNAMODB_ACTIVITY_LOG_TABLE'] || Rails.application.secrets[:dynamodb_activity_log_table]
