class OusController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_ous
  respond_to :json

  def index
    respond_with @ous
  end
  
  private
  
  def load_ous
    groups_table = Group.arel_table
    
    if params[:q]
      @ous = Group.with_permissions_to(:read).where(groups_table[:name].matches("%#{params[:q]}%").and(groups_table[:code].not_eq(nil)))
    else
      @ous = Group.with_permissions_to(:read).where(groups_table[:code].not_eq(nil))
    end
  end
end
