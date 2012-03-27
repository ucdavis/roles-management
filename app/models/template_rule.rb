class TemplateRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( owns\ application has\ unique\ group  )
  validates :template_id, :value, :condition, :presence => true
  
  belongs_to :template

  
end
