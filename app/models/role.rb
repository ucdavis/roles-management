class Role < ActiveRecord::Base
  has_many :assignments, :as => :assignable
end
