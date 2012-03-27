class TemplateRule < ActiveRecord::Base
  validates_inclusion_of :condition, :in => %w( Owns\ Application Owns\ Unique\ Application Has\ Unique\ Group )
  validates :template_id, :value, :condition, :presence => true
  
  belongs_to :template

  
end
