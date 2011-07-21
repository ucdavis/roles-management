class Role < ActiveRecord::Base
  has_and_belongs_to_many :roles,
                          :join_table => "roles_roles",
                          :foreign_key => "role_id",
                          :association_foreign_key => "subrole_id"
end
