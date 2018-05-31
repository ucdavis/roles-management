region = ENV['DYNAMODB_REGION'] || Rails.application.secrets[:dynamodb_region]
access_key = ENV['DYNAMODB_AWS_ACCESS_KEY'] || Rails.application.secrets[:dynamodb_aws_access_key]
secret_key = ENV['DYNAMODB_AWS_SECRET_KEY'] || Rails.application.secrets[:dynamodb_aws_secret_key]

Aws.config.update({
  region: region,
  credentials: Aws::Credentials.new(access_key, secret_key)
})

if region && access_key && secret_key
  ::DynamoDbClient = Aws::DynamoDB::Client.new
  ::DynamoDbTable = ENV['DYNAMODB_ACTIVITY_LOG_TABLE'] || Rails.application.secrets[:dynamodb_activity_log_table]
end
