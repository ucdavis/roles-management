class CleanUpBlankAdPathsInRoles < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)
    
    Role.where(:ad_path != nil).each do |r|
      if r.ad_path.blank?
        r.ad_path = nil
        r.save!
      end
    end
    
    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible."
  end
end
