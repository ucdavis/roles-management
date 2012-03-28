class Template < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :rules, :class_name => "TemplateRule"
  has_many :assignments, :class_name => "TemplateAssignment"
end
