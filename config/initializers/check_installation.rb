# Some checks to ensure user completed installation successfully as described
# in README.md.

# Application may not exist on 'rake db:setup' so check for ActiveRecord::StatementInvalid
begin
  rm_app = Application.includes(:roles).find_by_name("DSS Roles Management")

  unless rm_app
    Authorization.ignore_access_control(true)

    rm_application = Application.create({ name: 'DSS Roles Management' }) #, description: 'Manage and organize people with roles.' })

    Role.create({ token: 'access', application_id: rm_application.id, name: 'Access', description: 'Allow basic access' })
    Role.create({ token: 'admin', application_id: rm_application.id, name: 'Admin', description: 'Allow administrator access' })

    Authorization.ignore_access_control(false)
  end
rescue ActiveRecord::StatementInvalid => e
end
