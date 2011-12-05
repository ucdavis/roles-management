class GroupRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( may\ be may\ not\ be  )
  validates_inclusion_of :column, :in => %w( title major affiliation classification loginid  )
  
  belongs_to :group
  
  # Discern the rule and return a UID and name for the person
  def resolve
    u = []
    
    case column
    when "title"
      uids = Person.where(:title_id => Title.find_by_name(value)).collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        u = u + uids
      when "may not be"
        puts " -- 'title may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for title in group rule."
      end
    when "major"
      puts "Any condition involving 'major' is currently unsupported."
    when "affiliation"
      uids = Affiliation.find_by_name(value).people.collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        u = u + uids
      when "may not be"
        puts " -- 'affiliation may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for affiliation in group rule."
      end
    when "classification"
      title_ids = Title.where(:id => Classification.find_by_name(value).title_ids)
      uids = Person.where(:title_id => title_ids).collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        u = u + uids
      when "may not be"
        puts " -- 'classification may not be' is unsupported"
      else
        # unsupported
        puts "Unsupported condition for classification in group rule."
      end
    when "loginid"
      uids = Person.where(:loginid => value).collect{|x| ["1" + x.id.to_s, x.name]}
      case condition
      when "may be"
        u = u + uids
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
    
    u
  end
end
