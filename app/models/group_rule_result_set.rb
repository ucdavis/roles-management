# Holds GroupRuleResults so they may be shared to multiple GroupRules with identical values
class GroupRuleResultSet < ApplicationRecord
  has_many :rules, class_name: 'GroupRule'
  has_many :results, class_name: 'GroupRuleResult', dependent: :destroy

  validates_presence_of :column, :value
  validates_inclusion_of :column, in: GroupRule::VALID_COLUMNS
  validates_uniqueness_of :column, scope: :value

  validate do |grs|
    if (grs.column == 'is_staff' ||
        grs.column == 'is_faculty' ||
        grs.column == 'is_student' ||
        grs.column == 'is_employee' ||
        grs.column == 'is_hs_employee' ||
        grs.column == 'is_external') && (grs.value != 't' && grs.value != '1')
      grs.errors[grs.column] << "Must use true value ('t' or '1'). Use 'is not' for false values."
    end
  end

  # Ensure column and value are immutable
  validate do
    if persisted?
      if column_changed?
        errors.add(:column, "Attribute 'column' is immutable")
      elsif value_changed?
        errors.add(:value, "Attribute 'value' is immutable")
      end
    end
  end

  # Need to calculate results when a new GroupRuleResultSet is created, typically
  # by being linked into existence when a GroupRule is created.
  after_create do |grs|
    grs.update_results
  end

  after_touch do |_grs|
    Rails.logger.debug "GroupRuleResultSet #{id}: after_touch will touch each rule, count #{rules.length}"
    rules.each(&:touch)
  end

  # Calculate the results of the rule and cache in GroupRuleResult instances
  def update_results
    Rails.logger.debug "GroupRuleResultSet #{id}: Updating results for group rule set ##{id}"

    p = GroupRule.find_matches(column, value)

    # Compare new and existing results to selectively destroy/create GroupRuleResult records as needed
    existing_results = results.to_a
    new_results = p.uniq.map { |e| GroupRuleResult.new(entity_id: e.id, group_rule_result_set_id: id) }

    outdated_results = existing_results.reject do |er|
      new_results.reject! { |nr| (nr.entity_id == er.entity_id) && (nr.group_rule_result_set_id == er.group_rule_result_set_id) } != nil
    end

    outdated_results.each(&:destroy)
    new_results.each do |nr|
      results << nr
    end

    update_occurred = !(outdated_results.empty? && new_results.empty?)

    if update_occurred
      self.touch # rubocop:disable Style/RedundantSelf
      Rails.logger.debug "GroupRuleResultSet #{id}: Updated group rule set ##{id} to have #{results.length} result(s)"
    else
      Rails.logger.debug "GroupRuleResultSet #{id}: No update necessary for group rule set ##{id} (has #{results.length} result(s))"
    end
  end

  def destroy_if_unused
    destroy if rules.empty?
  end
end
