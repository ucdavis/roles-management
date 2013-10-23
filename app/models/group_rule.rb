# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ActiveRecord::Base
  using_access_control
  
  VALID_COLUMNS = %w( title major affiliation classification loginid ou )
  
  validates_presence_of :condition, :column, :value
  validates_inclusion_of :condition, :in => %w( is is\ not  )
  validates_inclusion_of :column, :in => VALID_COLUMNS
  
  belongs_to :group, :touch => true
  has_many :results, :class_name => "GroupRuleResult", :dependent => :destroy
  
  after_save :resolve_if_changed
  
  # Needed by 'Group' when calculating rules
  def GroupRule.valid_columns
    VALID_COLUMNS
  end
  
  # Class method to recalculate all rules related to column and entity_id.
  # Similar to resolve! but only involves removing/adding results for a specific person
  def GroupRule.resolve_target!(column, entity_id)
    unless VALID_COLUMNS.include? column.to_s
      raise "Cannot resolve_target for unknown column '#{column}'"
    end
    
    # Remove any existing rule results for this (person, column) duple
    GroupRuleResult.includes(:group_rule).where(:entity_id => entity_id, :group_rules => { :column => column.to_s }).destroy_all
    
    entity = Entity.find_by_id(entity_id)
    
    # Figure out which rules the entity matches specifically and add them
    case column
    when :title
      if entity.title
        GroupRule.where(:column => "title").each do |rule|
          if rule.condition == "is"
            if rule.value == entity.title.name
              rule.results << GroupRuleResult.new(:entity_id => entity_id)
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
              rule.results << GroupRuleResult.new(:entity_id => entity_id)
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
              rule.results << GroupRuleResult.new(:entity_id => entity_id)
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
              rule.results << GroupRuleResult.new(:entity_id => entity_id)
            end
          elsif rule.condition == "is not"
            logger.warn "Cannot GroupRule.resolve_target! for 'ou is not'. Unimplemented behavior."
          end
        end
      end
    when :classification
      if entity.title
        entity.title.classifications.each do |classification|
          GroupRule.where(:column => "classification").each do |rule|
            if rule.condition == "is"
              if rule.value == classification.name
                rule.results << GroupRuleResult.new(:entity_id => entity_id)
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
            rule.results << GroupRuleResult.new(:entity_id => entity_id)
          end
        elsif rule.condition == "is not"
          logger.warn "Cannot GroupRule.resolve_target! for 'loginid is not'. Unimplemented behavior."
        end
      end
    end
  end
  
  # Calculate the results of the rule and cache in GroupRuleResult instances
  def resolve!
    p = []
    
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
    self.resolve! if self.changed?
  end
end
