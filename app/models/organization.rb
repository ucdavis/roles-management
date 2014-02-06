class Organization < ActiveRecord::Base
  belongs_to :parent_organization, :class_name => 'Organization', :foreign_key => 'parent_org_id', :primary_key => 'org_id'
  has_many :child_organizations, :class_name => 'Organization', :foreign_key => 'parent_org_id', :primary_key => 'org_id'
  
  validates_uniqueness_of :org_id
  validates_presence_of :dept_code, :name, :org_id

  attr_accessible :dept_code, :org_id, :name, :parent_org_id

  before_validation :ensure_dept_code_is_left_padded
  
  # def parent_organization
  #   Organization.find_by_org_id(parent_org_id)
  # end

  private

  # UCD department codes are left-padded to ensure a six-digit "number"
  # (stored as a string though)
  def ensure_dept_code_is_left_padded
    self.dept_code = "%06d" % self.dept_code.to_i if attribute_present?("dept_code")
  end
end

