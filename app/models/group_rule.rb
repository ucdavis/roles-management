# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ActiveRecord::Base
  using_access_control
  
  VALID_COLUMNS = %w( title major affiliation classification loginid ou organization )
  
  validates_presence_of :condition, :column, :value, :group_id
  validates_inclusion_of :condition, :in => %w( is is\ not  )
  validates_inclusion_of :column, :in => VALID_COLUMNS
  
  belongs_to :group, :touch => true
  has_many :results, :class_name => "GroupRuleResult", :dependent => :destroy
  
  after_save :resolve_if_changed
  after_destroy :group_must_recalculate
  
  # Needed by 'Group' when calculating rules
  def GroupRule.valid_columns
    VALID_COLUMNS
  end
  
  # Class method to recalculate all rules related to column and entity_id.
  # Similar to resolve! but only involves removing/adding results for a specific person
  def GroupRule.resolve_target!(column, entity_id)
    touched_group_ids = [] # Record all groups touched by rule changes as they will need to recalculate their members
    
    Rails.logger.tagged "GroupRule.resolve_target!" do
      unless VALID_COLUMNS.include? column.to_s
        raise "Cannot resolve_target for unknown column '#{column}'"
      end
    
      logger.info "Resolving target entity ID #{entity_id} for column #{column}"
    
      # Remove any existing rule results for this (person, column) duple
      expired_rule_results = GroupRuleResult.includes(:group_rule).where(:entity_id => entity_id, :group_rules => { :column => column.to_s })
      expired_rule_results.each do |result|
        touched_group_ids << result.group_rule.group.id
      end
      logger.info "Expiring #{expired_rule_results.length} rules"
      expired_rule_results.destroy_all
    
      entity = Entity.find_by_id(entity_id)
      unless entity
        logger.warn "Could not find entity with ID #{entity_id}"
        return
      end
    
      # Figure out which rules the entity matches specifically and add them
      case column
      when :title
        if entity.title
          GroupRule.where(:column => "title").each do |rule|
            if rule.condition == "is"
              if rule.value == entity.title.name
                logger.info "Matched 'title is' rule. Recording result."
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
                touched_group_ids << rule.group.id
              end
            elsif rule.condition == "is not"
              logger.warn "Cannot GroupRule.resolve_target! for 'title is not'. Unimplemented behavior."
            end
          end
        end
      when :major
        if entity.major
          GroupRule.where(:column => "major").each do |rule|
            if rule.condition == "is"
              if rule.value == entity.major.name
                logger.info "Matched 'major is' rule. Recording result."
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
                touched_group_ids << rule.group.id
              end
            elsif rule.condition == "is not"
              logger.warn "Cannot GroupRule.resolve_target! for 'major is not'. Unimplemented behavior."
            end
          end
        end
      when :affiliation
        entity.affiliations.each do |entity_affiliation|
          GroupRule.where(:column => "affiliation").each do |rule|
            if rule.condition == "is"
              if rule.value == entity_affiliation.name
                logger.info "Matched 'affiliation is' rule. Recording result."
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
                touched_group_ids << rule.group.id
              end
            elsif rule.condition == "is not"
              logger.warn "Cannot GroupRule.resolve_target! for 'affiliation is not'. Unimplemented behavior."
            end
          end
        end
      when :ou
        entity.groups.ous.each do |ou|
          GroupRule.where(:column => "ou").each do |rule|
            if rule.condition == "is"
              if rule.value == ou.name
                logger.info "Matched 'ou is' rule. Recording result."
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
                touched_group_ids << rule.group.id
              end
            elsif rule.condition == "is not"
              logger.warn "Cannot GroupRule.resolve_target! for 'ou is not'. Unimplemented behavior."
            end
          end
        end
      when :organization
        entity.organizations.each do |organization|
          GroupRule.where(:column => "organization").each do |rule|
            if rule.condition == "is"
              if rule.value == organization.name
                logger.info "Matched 'Organization is' rule. Recording result."
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
                touched_group_ids << rule.group.id
                
                touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(organization, entity_id)
              end
            elsif rule.condition == "is not"
              logger.warn "Cannot GroupRule.resolve_target! for 'Organization is not'. Unimplemented behavior."
            end
          end
        end
      when :classification
        if entity.title
          entity.title.classifications.each do |classification|
            GroupRule.where(:column => "classification").each do |rule|
              if rule.condition == "is"
                if rule.value == classification.name
                  logger.info "Matched 'classification is' rule. Recording result."
                  rule.results << GroupRuleResult.new(:entity_id => entity_id)
                  touched_group_ids << rule.group.id
                end
              elsif rule.condition == "is not"
                logger.warn "Cannot GroupRule.resolve_target! for 'classification is not'. Unimplemented behavior."
              end
            end
          end
        end
      when :loginid
        GroupRule.where(:column => "loginid").each do |rule|
          if rule.condition == "is"
            if rule.value == entity.loginid
              logger.info "Matched 'loginid is' rule. Recording result."
              rule.results << GroupRuleResult.new(:entity_id => entity_id)
              touched_group_ids << rule.group.id
            end
          elsif rule.condition == "is not"
            logger.warn "Cannot GroupRule.resolve_target! for 'loginid is not'. Unimplemented behavior."
          end
        end
      end
      
      touched_group_ids.flatten.uniq.each do |touched_group_id|
        logger.info "Alerting group ##{touched_group_id} to recalculate as at least one of its rules were touched."
        Group.find_by_id(touched_group_id).recalculate_members!
      end
    end
  end
  
  # Assumes rule is 'Organization is...'
  # This function recurses through an organization's parents (and their parents and their parents and...)
  # looks for any GroupRules associated with that organization. If it finds any, it adds entity_id
  # as a valid GroupRuleResult.
  # The opposite behavior (removing an entity) is handled by the fact that resolve_target! begins its
  # algorithm by removing all GroupRuleResults for an entity_id.
  def resolve_target_assign_organization_parents!(organization, entity_id)
    touched_group_ids = []
    
    organization.parents do |parent|
      # Find all rules affecting this parent
      rules = GroupRule.find_by_column_and_condition_and_value('organization', 'is', parent.name)
      rules.each do |rule|
        # Add the entity to the rule's results
        rule.results << GroupRuleResult.new(:entity_id => entity_id)
        touched_group_ids << rule.group.id
      end
      
      # Do the same for this parent's parents
      touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(parent, entity_id)
    end
    
    return touched_group_ids.flatten.uniq
  end
  
  # Calculate the results of the rule and cache in GroupRuleResult instances
  def resolve!
    p = []
    
    logger.info "Resolving (calculating) group rule ##{id}"
    
    case column
    when "title"
      ps = Person.where(:title_id => Title.find_by_name(value))
      case condition
      when "is"
        p = p + ps
      when "is not"
        logger.info " -- 'title is not' will not be resolved within GroupRule"
      else
        # unsupported
        logger.warn "Unsupported condition for title in group rule."
      end
    when "major"
      major = Major.find_by_name(value)
      unless major.nil?
        ps = major.people
        case condition
        when "is"
          p = p + ps
        when "is not"
          logger.info " -- 'major is not' will not be resolved within GroupRule"
        else
          # unsupported
          logger.warn "Unsupported condition for major in group rule."
        end
      end
    when "affiliation"
      affiliation = Affiliation.find_by_name(value)
      unless affiliation.nil?
        ps = affiliation.people
        case condition
        when "is"
          p = p + ps
        when "is not"
          logger.info " -- 'affiliation is not' will not be resolved within GroupRule"
        else
          # unsupported
          logger.warn "Unsupported condition for affiliation in group rule."
        end
      end
    when "ou"
      ou = Group.ous.includes(:members).find_by_name(value)
      unless ou == nil
        ps = ou.members
        case condition
        when "is"
          p = p + ps
        when "is not"
          logger.info " -- 'OU is not' will not be resolved within GroupRule"
        else
          # unsupported
          logger.warn "Unsupported condition for OU in group rule."
        end
      else
        logger.warn "OU not found"
      end
    when "organization"
      organization = Organization.includes(:entities).find_by_name(value)
      if organization
        # We do not consider groups which belong to organizations in our calculations by design
        ps = organization.flattened_entities
        case condition
        when "is"
          p = p + ps
        when "is not"
          logger.info " -- 'Organization is not' will not be resolved within GroupRule"
        else
          # unsupported
          logger.warn "Unsupported condition for Organization in group rule."
        end
      else
        logger.warn "Organization not found"
      end
    when "classification"
      classification = Classification.find_by_name(value)
      unless classification == nil
        title_ids = Title.where(:id => classification.title_ids)
        ps = Person.where(:title_id => title_ids)
        case condition
        when "is"
          p = p + ps
        when "is not"
          logger.info " -- 'classification is not' will not be resolved within GroupRule"
        else
          # unsupported
          logger.warn "Unsupported condition for classification in group rule."
        end
      else
        logger.warn "Classification not found"
      end
    when "loginid"
      ps = Person.where(:loginid => value)
      case condition
      when "is"
        p = p + ps
      when "is not"
        logger.info " -- 'loginid is not' will not be resolved within GroupRule"
      else
        # unsupported
        logger.warn "Unsupported condition for loginid in group rule."
      end
    else
      # Undefined column
      logger.warn " -- unhandled column (#{column})"
    end
    
    # Save the result in GroupRuleResults
    results.destroy_all
    
    p.each do |e|
      results << GroupRuleResult.new(:entity_id => e.id)
    end
    
    logger.info "Resolved group rule ##{id} to have #{results.length} results"
  end

  # Returns true if the given person satisfies the rule
  def matches(person_id)
    # 'cond' is a boolean representing this rule's 'is' or 'is not'
    cond = (condition == "is")
    matched = nil
    
    person = Person.find_by_id(person_id)

    case column
    when "title"
      matched = person.title == Title.find_by_name(value)
    when "major"
      matched = person.major == Major.find_by_name(value)
    when "affiliation"
      matched = person.affiliations.include? Affiliation.find_by_name(value)
    when "ou"
      matched = person.groups.ous.include? Group.find_by_name(value)
    when "organization"
      matched = person.organizations.include? Organization.find_by_name(value)
    when "classification"
      matched = person.classification == Classification.find_by_name(value)
    when "loginid"
      matched = person.loginid == value
    end

    return cond == matched
  end

  private
  
  # Recalculates group members if anything changed. Called after_save.
  def resolve_if_changed
    self.resolve! if self.changed? # recalculate this rule
    self.group.recalculate_members! if self.changed? # tell the group to recombine the results list
  end
  
  # In after_destroy it's important the group recalculate members as this rule is gone
  def group_must_recalculate
    self.group.recalculate_members!
  end
end
