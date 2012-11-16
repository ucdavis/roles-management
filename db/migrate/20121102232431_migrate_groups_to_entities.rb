class MigrateGroupsToEntities < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)

    Group.set_table_name "groups"

    Group.all.each do |g|
      e = Entity.new

      e.id = g.uid
      e.type = "Group"
      e.created_at = g.created_at
      e.updated_at = g.updated_at
      e.name = g.name
      e.description = g.description
      e.code = g.code

      e.save
    end

    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
