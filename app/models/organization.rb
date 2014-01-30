class Organization < ActiveRecord::Base
  validates_uniqueness_of :org_id
  validates_presence_of :dept_code, :name, :org_id

  attr_accessible :dept_code, :org_id, :name, :parent_organization_id

  before_validation :ensure_dept_code_is_left_padded

  private

  # UCD department codes are left-padded to ensure a six-digit "number"
  # (stored as a string though)
  def ensure_dept_code_is_left_padded
    self.dept_code = "%06d" % self.dept_code.to_i if attribute_present?("dept_code")
  end
end

