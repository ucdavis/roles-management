class GroupRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( may\ be may\ not\ be  )
  validates_inclusion_of :column, :in => %w( title major affiliation classification loginid  )
  
  # Discern the rule and return a UID and name for the person
  def resolve
    u = {}
    
    case :column
    when "title"
      
    when "major"
      
    when "affiliation"
      
    when "classification"
      case :condition
      when "may be"
        
      when "may not be"
        
      else
        # unsupported
      end
    when "loginid"
      
    else
      # Undefined column
    end
    
    u
  end
end
