class EnsurePersonEntitiesHaveNames < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)
    Person.all.each do |p|
      if p.name.nil?
        p.name = p.first + " " + p.last
        p.save
      end
    end
    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
