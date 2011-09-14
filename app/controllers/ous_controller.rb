class OusController < ApplicationController
  before_filter :load_ou, :only => [:show, :edit, :update]
  filter_resource_access

  # GET /ous
  def index
    @ous = Ou.top_level

    respond_to do |format|
      format.html
    end
  end

  # GET /ous/1
  def show
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
    if params[:delete]
      @ou.destroy
      respond_to do |format|
        format.html { redirect_to(ous_url, :notice => 'Organization was successfully deleted.') }
      end
    else
      respond_to do |format|
        if @ou.update_attributes(params[:ou])
          format.html { redirect_to(@ou, :notice => 'Organization was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
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
  
  # FIXME: This is really ugly code.
  def load_ou
    if permitted_to? :show, :ous
      if Ou.find_by_name(params[:id])
        @ou = Ou.find_by_name(params[:id])
      else
        # Name-based URLs means we can't have / in the name. Try replacing any _ with / and search again
        if Ou.find_by_name(params[:id].gsub("_", "/"))
          @ou = Ou.find_by_name(params[:id].gsub("_", "/"))
        else
          # Maybe assume the _ is an &
          if Ou.find_by_name(params[:id].gsub("_", "&"))
            @ou = Ou.find_by_name(params[:id].gsub("_", "&"))
          else
            # Give up if it's not this
            @ou = Ou.find_by_name(params[:id].gsub("_", "."))
          end
        end
      end
    end
  end
end
