class EnsureDefaultRmAppExists < ActiveRecord::Migration
  def up
    a = Application.new
    a.name = "DSS Rights Management"
    a.save
    r = Role.new
    r.token = "admin"
    r.descriptor = "Administrative Rights"
    r.description = "Administrative Rights"
    r.save
    a.roles << r
  end

  def down
  end
end
