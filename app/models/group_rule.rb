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
        puts " -- 'title may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for title in group rule."
      end
    when "major"
      puts "Any condition involving 'major' is currently unsupported."
    when "affiliation"
      ps = Affiliation.find_by_name(value).people #.collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        p = p + ps
      when "may not be"
        puts " -- 'affiliation may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for affiliation in group rule."
      end
    when "ou"
      ou = Ou.find_by_name(value)
      unless ou == nil
        ps = ou.members
        case condition
        when "may be"
          p = p + ps
        when "may not be"
          puts " -- 'OU may not be' is unsupported"
        else
          # unsupported
          puts "Unsupported condition for OU in group rule."
        end
      else
        puts "OU not found"
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
          puts " -- 'classification may not be' is unsupported"
        else
          # unsupported
          puts "Unsupported condition for classification in group rule."
        end
      else
        puts "Classification not found"
      end
    when "loginid"
      ps = Person.where(:loginid => value) #.collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        p = p + ps
      when "may not be"
        puts " -- 'loginid may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for loginid in group rule."
      end
    else
      # Undefined column
      puts " -- unknown rule type (#{column})"
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
