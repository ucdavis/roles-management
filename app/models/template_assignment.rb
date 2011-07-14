class TemplateAssignment < ActiveRecord::Base
  has_many :assignments, :as => :assignable
end
