# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
Authorization.ignore_access_control(true)

rm_application = Application.create({ name: 'DSS Roles Management', description: 'Manage and organize people and groups with roles.' })

Role.create({ token: 'access', application_id: rm_application.id, name: 'Access', description: 'Allow basic program access' })
Role.create({ token: 'admin', application_id: rm_application.id, name: 'Admin', description: 'Allow full administrator access' })
Role.create({ token: 'operate', application_id: rm_application.id, name: 'Operate', description: 'Allows trusted, administrator-like access with notable restrictions' })

Authorization.ignore_access_control(false)
