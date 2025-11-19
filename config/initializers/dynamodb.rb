region = ENV['DYNAMODB_REGION']
access_key = ENV['DYNAMODB_AWS_ACCESS_KEY']
secret_key = ENV['DYNAMODB_AWS_SECRET_KEY']
endpoint = ENV['DYNAMODB_ENDPOINT']

Aws.config.update(
  region: region,
  credentials: Aws::Credentials.new(access_key, secret_key)
)

if access_key.present?
  if endpoint.present?
    ::DynamoDbClient = Aws::DynamoDB::Client.new(endpoint: endpoint, region: region)
  else
    ::DynamoDbClient = Aws::DynamoDB::Client.new
  end
  ::DynamoDbTable = ENV['DYNAMODB_ACTIVITY_LOG_TABLE']
end
