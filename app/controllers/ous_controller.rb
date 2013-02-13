class OusController < ApplicationController
  filter_access_to :all
  respond_to :json

  def index
    if params[:q]
      @groups = Group.where(Group.arel_table[:code].not_eq(nil)).where("upper(name) like ?", "%#{params[:q].upcase}%")
    else
      @groups = Group.where(Group.arel_table[:code].not_eq(nil))
    end

    respond_with @groups
  end
end
