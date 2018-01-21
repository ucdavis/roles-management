class SisAssociation < ApplicationRecord
  belongs_to :entity
  belongs_to :major

  # LDAP cannot fill in these fields so we cannot validate their presence.
  # Once we switch fully from LDAP to IAM, these fields should be validated.
  # validates_presence_of :association_rank
  # validates_presence_of :level_code

  after_save do
    GroupRuleSet.update_results_for(:sis_level_code, entity_id)
    GroupRuleSet.update_results_for(:major, entity_id)
  end
  after_destroy do
    GroupRuleSet.update_results_for(:sis_level_code, entity_id)
    GroupRuleSet.update_results_for(:major, entity_id)
  end
end
