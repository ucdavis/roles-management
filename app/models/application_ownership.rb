class ApplicationOwnership < ActiveRecord::Base
  using_access_control

  belongs_to :application, :touch => true
  belongs_to :owner, :class_name => "Person", :touch => true
  validates_uniqueness_of :application_id, :scope => :owner_id
end
