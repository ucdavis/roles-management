class DefaultEntityStatusToTrue < ActiveRecord::Migration
  def change
    change_column_default :entities, :status, true
    
    Authorization.ignore_access_control(true)
    Entity.where(:status => nil).each do |e|
      e.status = true
      e.save
    end
    Authorization.ignore_access_control(false)
  end
end
