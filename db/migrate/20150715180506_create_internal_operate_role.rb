class CreateInternalOperateRole < ActiveRecord::Migration
  def up
    rm_app = Application.find_by_name("DSS Roles Management")

    raise "Internal 'DSS Roles Management' application missing." unless rm_app

    Authorization.ignore_access_control(true)

    r = Role.new
    r.token = "operate"
    r.name = "Operator Rights"
    r.description = "Allows trusted, administrator-like access with notable restrictions"
    r.application = rm_app
    r.save!

    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
