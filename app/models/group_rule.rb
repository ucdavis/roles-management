class GroupRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( may\ be may\ not\ be  )
  
  
end
