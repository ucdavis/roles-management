class GroupRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( may\ be may\ not\ be  )
  validates_inclusion_of :column, :in => %w( title major affiliation classification loginid  )
  
end
