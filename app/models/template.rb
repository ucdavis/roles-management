class Template < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  has_many :rules, :class_name => "TemplateRule"
end
