class Template < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :rules, :class_name => "TemplateRule"
  has_many :assignments, :class_name => "TemplateAssignment"
  
  # Returns a list of the UIDs of each assignment
  def assignment_uids
    uids = []
    
    assignments.each do |assignment|
      uids << assignment.resolve
    end
    
    uids
  end
end
