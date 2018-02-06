class SisAssociation < ApplicationRecord
  include Immutable

  belongs_to :entity
  belongs_to :major

  # LDAP cannot fill in these fields so we cannot validate their presence.
  # Once we switch fully from LDAP to IAM, these fields should be validated.
  # validates_presence_of :association_rank
  # validates_presence_of :level_code

  after_save do
    GroupRuleResultSet.update_results_for(:sis_level_code, entity_id)
    GroupRuleResultSet.update_results_for(:major, entity_id)
    ActivityLog.info!("Added major #{major.name}", ["person_#{entity.id}"])
  end
  after_destroy do
    GroupRuleResultSet.update_results_for(:sis_level_code, entity_id)
    GroupRuleResultSet.update_results_for(:major, entity_id)
    ActivityLog.info!("Removed major #{major.name}", ["person_#{entity.id}"])
  end
end
