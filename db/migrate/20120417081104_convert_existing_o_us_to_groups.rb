class ConvertExistingOUsToGroups < ActiveRecord::Migration
  def up
    # Temporarily map the old OU id to the new group ID as we cannot perform the migration in a single step
    #mappings = {}
    
    #ActiveRecord::Base.transaction do
      #Ou.all.each do |ou|
        # Create a group for each OU
        #g = Group.new
        #g.name = ou.name
        #g.code = ou.code
            
        # Preverse OU manager assignment as group owner assignment
        #ou.managers.each do |manager|
          #g.owners << manager
          #end
      
        # Copy all members of this OU to the new group
        #ou.members.each do |member|
          #g.people << member
          #end
      
        #g.save!
      
        # Store the mapping only after saving (so .id is valid)
        #mappings[ou.id] = g.id
        #end
    
      # Copy all OU-to-OU relationships only after all new groups are created
      #Ou.all.each do |ou|
        #g = Group.find_by_id(mappings[ou.id])
      
        #ou.children.each do |child|
          #g.groups << Group.find_by_id(mappings[child.id])
          #end
      #end
      #end
  end

  def down
    puts "This migration is not reversible."
  end
end
