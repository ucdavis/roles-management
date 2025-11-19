require 'rake'

namespace :activitylog do
  desc 'Create required table in DynamoDB'
  task create_table: :environment do
    params = {
      table_name: ENV['DYNAMODB_ACTIVITY_LOG_TABLE'],
      key_schema: [
        {
          attribute_name: 'LogEntityId',
          key_type: 'HASH' # Partition key
        },
        {
          attribute_name: 'UUID',
          key_type: 'RANGE' # Sort key
        }
      ],
      attribute_definitions: [
        {
          attribute_name: 'LogEntityId',
          attribute_type: 'S'
        },
        {
          attribute_name: 'UUID',
          attribute_type: 'S'
        },
      ],
      provisioned_throughput: {
        read_capacity_units: 5,
        write_capacity_units: 5
      }
    }

    begin
      result = DynamoDbClient.create_table(params)

      puts 'Created table. Status: ' + result.table_description.table_status
    rescue Aws::DynamoDB::Errors::ServiceError => error
      puts 'Unable to create table:'
      puts error.message
    end
  end
end
