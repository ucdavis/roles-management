class ApplicationOuAssignment < ActiveRecord::Base
  belongs_to :ou
  belongs_to :application
end
