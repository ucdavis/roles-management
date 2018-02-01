class AffiliationAssignment < ApplicationRecord
  include Immutable

  belongs_to :affiliation, touch: true
  belongs_to :person, touch: true

  after_create :recalculate_affiliation_group_rules_if_necessary
  after_destroy :recalculate_affiliation_group_rules_if_necessary

  private

  # Recalculates any groups with rules based on affiliation.
  # This logic exists here and not in GroupRule as it is the
  # best place to catch affiliation assignments being created
  # and destroyed.
  def recalculate_affiliation_group_rules_if_necessary
    GroupRuleResultSet.update_results_for(:affiliation, person_id)
  end
end
