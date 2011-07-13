class Assignment < ActiveRecord::Base
  has_many :assignments, :class_name => "Assignment", :foreign_key => "assignment_id"
  belongs_to :assignment, :class_name => "Assignment"
  
  belongs_to :assignable, :polymorphic => true
end
