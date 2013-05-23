class OusController < ApplicationController
  filter_access_to :all, :attribute_check => true, :load_method => :load_ous
  respond_to :json

  def index
    respond_with @groups
  end
  
  private
  
  def load_ous
    if params[:q]
      @groups = Group.where(Group.arel_table[:code].not_eq(nil)).where("upper(name) like ?", "%#{params[:q].upcase}%")
    else
      @groups = Group.where(Group.arel_table[:code].not_eq(nil))
    end
  end
end
