# Some checks to ensure user completed installation successfully as described
# in README.md.

# Application may not exist on 'rake db:setup' so check for ActiveRecord::StatementInvalid
begin
  rm_app = Application.includes(:roles).find_by_name("DSS Roles Management")

  unless rm_app
    rm_application = Application.create({ name: 'DSS Roles Management' })

    Role.create({ token: 'access', application_id: rm_application.id, name: 'Access', description: 'Allow basic access' })
    Role.create({ token: 'admin', application_id: rm_application.id, name: 'Admin', description: 'Allow administrator access' })
  end
rescue ActiveRecord::StatementInvalid => e
  # Oh well
rescue Mysql2::Error => e
  # Oh well
end
