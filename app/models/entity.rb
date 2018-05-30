class Entity < ApplicationRecord
  # 'favored_by_relationships' exists solely so favorite assignments are removed when an entity is deleted.
  has_many :favored_by_relationships, class_name: 'PersonFavoriteAssignment', foreign_key: 'entity_id', dependent: :destroy
  has_many :group_rule_results, dependent: :destroy

  def person?
    type == 'Person'
  end

  def group?
    type == 'Group'
  end

  # We need to be able to assign :type when creating an entity using the Entity super-class
  def self.attributes_protected_by_default
    # default is ["id","type"]
    ['id']
  end

  # Retrieve ActivityLog for this entity order by most recent. nil if none
  def activity
    tag = person? ? "person_#{id}" : "group_#{id}"

    params = {
      table_name: DynamoDbTable,
      key_condition_expression: "#LogEntityId = :id",
      expression_attribute_names: {
        "#LogEntityId" => "LogEntityId"
      },
      expression_attribute_values: {
        ":id" => tag
      }
    }

    activity = []

    begin
      result = DynamoDbClient.query(params)

      result.items.each do |item|
        activity.push OpenStruct.new(
          performed_at: Time.at(item["entry"]["logged_at"].to_f).to_datetime,
          message: item["entry"]["message"]
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
