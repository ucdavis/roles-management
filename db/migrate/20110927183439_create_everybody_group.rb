class CreateEverybodyGroup < ActiveRecord::Migration
  def up
    #g = Group.new
    #g.name = "Everybody"
    #Person.all.each do |person|
    #  g.people << person
    #end
    #g.save
  end

  def down
    # 'Everybody' group might be something else ... it's easy enough to delete manually in the UI
  end
end
