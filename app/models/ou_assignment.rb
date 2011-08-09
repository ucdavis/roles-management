class OuAssignment < ActiveRecord::Base
  belongs_to :ou
  belongs_to :person
end
