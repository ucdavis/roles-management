class Department < ApplicationRecord
  has_many :pps_associations
  has_many :people, through: :pps_associations
  has_one :business_office_unit, foreign_key: :org_oid, primary_key: :bou_org_oid
end
