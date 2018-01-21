class BusinessOfficeUnit < ApplicationRecord
  has_many :departments, primary_key: :org_oid, foreign_key: :bou_org_oid
end
