class GroupRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( may\ be may\ not\ be  )
  validates_inclusion_of :column, :in => %w( title major affiliation classification loginid ou )

  belongs_to :group

  # Discern the rule and return a UID and name for the person
  def resolve
    p = []

    case column
    when "title"
      ps = Person.where(:title_id => Title.find_by_name(value)) #.collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        p = p + ps
      when "may not be"
        logger.warn " -- 'title may not be' is unsupported"
      else
        # unsupported
        logger.warn "Unsupported condition for title in group rule."
      end
    when "major"
      major = Major.find_by_name(value)
      unless major.nil?
        ps = major.people #.collect{|x| ["1" + x.id.to_s, x.name]}
        case condition
        when "may be"
          p = p + ps
        when "may not be"
          logger.warn " -- 'major may not be' is unsupported"
        else
          # unsupported
          logger.warn "Unsupported condition for major in group rule."
        end
      end
    when "affiliation"
      affiliation = Affiliation.find_by_name(value)
      unless affiliation.nil?
        ps = affiliation.people #.collect{|x| ["1" + x.id.to_s, x.name]}
        case condition
        when "may be"
          p = p + ps
        when "may not be"
          logger.warn " -- 'affiliation may not be' is unsupported"
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
        when "may be"
          p = p + ps
        when "may not be"
          logger.warn " -- 'OU may not be' is unsupported"
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
        ps = Person.where(:title_id => title_ids) #.collect{|x| ["1" + x.id.to_s, x.name]}
        case condition
        when "may be"
          p = p + ps
        when "may not be"
          logger.warn " -- 'classification may not be' is unsupported"
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
      when "may be"
        p = p + ps
      when "may not be"
        logger.warn " -- 'loginid may not be' is unsupported"
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

  def print_formatted
    case column
    when 'title'
      str = "<b>Title</b> "
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
    when 'may be'
      str = str + "may be "
    when 'may not be'
      str = str + "may not be "
    end

    str = str + "<b>" + value + "</b>"

    str.html_safe
  end
end
