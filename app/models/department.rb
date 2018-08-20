class Department < ApplicationRecord
  has_many :pps_associations
  has_many :people, through: :pps_associations

  has_many :admin_pps_associations, foreign_key: 'admin_department_id', class_name: 'PpsAssociation'
  has_many :admin_people, through: :admin_pps_associations, source: :person

  has_many :appt_pps_associations, foreign_key: 'appt_department_id', class_name: 'PpsAssociation'
  has_many :appt_people, through: :appt_pps_associations, source: :person

  has_one :business_office_unit, foreign_key: :org_oid, primary_key: :bou_org_oid
end
