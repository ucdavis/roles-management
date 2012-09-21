class Major < ActiveRecord::Base
  using_access_control

  has_many :people

  # Needed by custom controller#majors, used in details modal
  def as_json(options={})
    { :id => self.id, :name => self.name }
  end
end
