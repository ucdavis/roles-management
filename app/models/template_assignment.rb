class TemplateAssignment < ActiveRecord::Base
  validates :template_id, :value, :condition, :presence => true
  
  belongs_to :template
  belongs_to :person
  belongs_to :group

  def assignment_ids
    
  end
end
