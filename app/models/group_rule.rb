class GroupRule < ActiveRecord::Base
  using_access_control

  @@valid_columns = %w( title major affiliation classification loginid ou )

  validates_inclusion_of :condition, :in => %w( is is\ not  )
  validates_inclusion_of :column, :in => @@valid_columns

  belongs_to :group
  
  after_save :clear_cache_if_needed
  before_destroy Proc.new { |model| model.clear_cache_if_needed(true) }

  # Needed by 'Group' when calculating rules
  def GroupRule.valid_columns
    @@valid_columns
  end

  # Resolve (discern) the rule and return a UID and name for the person
  def resolve
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
      ou = Group.find_by_name(value)
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
      ps = Person.where(:loginid => value) #.collect{|x| ["1" + x.id.to_s, x.name]}
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
      logger.warn " -- unknown rule type (#{column})"
    end

    p
  end

  # Returns true if the given person satisfies the rule
  def matches(person)
    # 'cond' is a boolean representing this rule's 'is' or 'is not'
    cond = (condition == "is")
    matched = nil

    case column
    when "title"
      matched = person.title == Title.find_by_name(value)
    when "major"
      matched = person.major == Major.find_by_name(value)
    when "affiliation"
      matched = person.affiliations.include? Affiliation.find_by_name(value)
    when "ou"
      matched = person.ous.include? Group.find_by_name(value)
    when "classification"
      matched = person.classification == Classification.find_by_name(value)
    when "loginid"
      matched = person.loginid == value
    end

    return cond == matched
  end

  def print_formatted
    case column
    when 'title'
      str = "<b>Title</b> "
    when 'ou'
      str = "<b>OU</b> "
    when 'loginid'
      str = "<b>Login ID</b> "
    when 'major'
      str = "<b>Major</b> "
    when 'affiliation'
      str = "<b>Affiliation</b> "
    when 'classification'
      str = "<b>Classification</b> "
    end

    case condition
    when 'is'
      str = str + "is "
    when 'is not'
      str = str + "is not "
    end

    str = str + "<b>" + value + "</b>"

    str.html_safe
  end

  def clear_cache_if_needed(force_clear = false)
    if self.changed? or force_clear
      logger.debug "Clearing cache for group #{group_id} because of change in rule #{id}"
      Rails.cache.delete("entities/member_tokens/#{group_id}")
      Rails.cache.delete("entities/rule_members/#{group_id}")
      # entities/members/#{flatten} (can be false or true), we may be storing both
      Rails.cache.delete("entities/members/false/#{group_id}")
      Rails.cache.delete("entities/members/true/#{group_id}")
      return true
    else
      return false
    end
  end
end
