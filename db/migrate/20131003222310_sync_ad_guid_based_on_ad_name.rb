class SyncAdGuidBasedOnAdName < ActiveRecord::Migration
  def up
    require 'active_directory_wrapper'
    
    Role.where(:ad_path != nil).each do |r|
      g = ActiveDirectoryWrapper.fetch_group(r.ad_path)
      
      puts "Found group #{g.name}. Saving GUID ..."
      
      r.ad_guid = g.objectguid
      r.save!
    end
  end

  def down
    puts "This migration is not reversible."
  end
end
