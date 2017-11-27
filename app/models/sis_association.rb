class SisAssociation < ApplicationRecord
  belongs_to :entity
  belongs_to :major

  # LDAP cannot fill in these fields so we cannot validate their presence.
  # Once we switch fully from LDAP to IAM, these fields should be validated.
  # validates_presence_of :association_rank
  # validates_presence_of :level_code

  after_save do
    GroupRule.resolve_target!(:sis_level_code, entity_id)
    GroupRule.resolve_target!(:major, entity_id)
  end
  after_destroy do
    GroupRule.resolve_target!(:sis_level_code, entity_id)
    GroupRule.resolve_target!(:major, entity_id)
  end
end
