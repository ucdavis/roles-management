class TemplateAssignment < ActiveRecord::Base
  validates :template_id, :presence => true
  # Must have either a person_id or group_id
  validates :person_id, :presence => true, :if => "group_id.nil?"
  validates :group_id, :presence => true, :if => "person_id.nil?"
  
  belongs_to :template
  belongs_to :person
  belongs_to :group

  # Returns the UID of this template assignment, regardless of whether it is group- or person-based
  def resolve
    uid = nil
    
    if person_id.nil?
      # Group-based
      uid = ('2' + group.id.to_s).to_i
    else
      # Person-based
      uid = ('1' + person.id.to_s).to_i
    end
    
    uid
  end
end
