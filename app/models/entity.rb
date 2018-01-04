class Entity < ApplicationRecord
  has_many :organization_entity_associations, dependent: :destroy
  has_many :organizations, through: :organization_entity_associations
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
    return []
    # tag = ActivityLogTag.find_by_tag("#{self.class.to_s.downcase}_#{self.id}")
    # return [] unless tag
    # return tag.activity_logs.order('performed_at DESC')
  end
end
