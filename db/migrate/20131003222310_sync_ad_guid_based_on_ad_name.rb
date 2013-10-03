class SyncAdGuidBasedOnAdName < ActiveRecord::Migration
  def up
    require 'active_directory_wrapper'
    
    Authorization.ignore_access_control(true)
    
    Role.where(:ad_path != nil).each do |r|
      g = ActiveDirectoryWrapper.fetch_group(r.ad_path)
      if g
        puts "Found group #{g.name}. Saving GUID ..."
      
        r.ad_guid = g.objectguid
        r.save!
      else
        puts "Could not find group with AD path #{r.ad_path} on role ID #{r.id}. Ignoring ..."
        next
      end
    end
    
    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
