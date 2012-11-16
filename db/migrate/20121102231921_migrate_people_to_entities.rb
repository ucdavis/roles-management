class MigratePeopleToEntities < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)

    Person.set_table_name "people"

    Person.all.each do |p|
      e = Entity.new

      e.id = p.uid
      e.type = "Person"
      e.first = p.first
      e.last = p.last
      e.email = p.email
      e.loginid = p.loginid
      e.name = p.preferred_name
      e.status = p.status
      e.phone = p.phone
      e.address = p.address
      e.title_id = p.title_id
      e.major_id = p.major_id
      e.created_at = p.created_at
      e.updated_at = p.updated_at

      e.save
    end

    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
