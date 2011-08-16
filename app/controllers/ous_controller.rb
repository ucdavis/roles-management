class OusController < ApplicationController
  before_filter :load_ou, :only => [:show]
  filter_resource_access

  # GET /ous
  def index
    @ous = Ou.where("name like ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html
      format.json { render :json => @ous.map(&:attributes) }
    end
  end

  # GET /ous/1
  def show
    @ou = Ou.find_by_name(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /ous/new
  def new
    @ou = Ou.new

    respond_to do |format|
      format.html
    end
  end

  # GET /ous/1/edit
  def edit
    @ou = Ou.find_by_name(params[:id])
  end

  # POST /ous
  def create
    @ou = Ou.new(params[:ou])

    respond_to do |format|
      if @ou.save
        format.html { redirect_to(@ou, :notice => 'Organization was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /ous/1
  def update
    @ou = Ou.find_by_name(params[:id])

    respond_to do |format|
      if @ou.update_attributes(params[:ou])
        format.html { redirect_to(@ou, :notice => 'Organization was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /ous/1
  def destroy
    @ou = Ou.find_by_name(params[:id])
    @ou.destroy

    respond_to do |format|
      format.html { redirect_to(ous_url) }
    end
  end
  
  protected
  
  def load_ou
    if permitted_to? :show, :ous
      @ou = Ou.find_by_name(params[:id])
    end
  end
end
