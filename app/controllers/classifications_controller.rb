class ClassificationsController < ApplicationController
  # GET /classifications
  def index
    @classifications = Classification.all

    respond_to do |format|
      format.html
    end
  end

  # GET /classifications/1
  def show
    @classification = Classification.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /classifications/new
  def new
    @classification = Classification.new

    respond_to do |format|
      format.html
    end
  end

  # GET /classifications/1/edit
  def edit
    @classification = Classification.find(params[:id])
  end

  # POST /classifications
  def create
    @classification = Classification.new(params[:classification])

    respond_to do |format|
      if @classification.save
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Created new classification, #{params[:classification]}."
        format.html { redirect_to @classification, notice: 'Classification was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /classifications/1
  def update
    @classification = Classification.find(params[:id])

    respond_to do |format|
      if @classification.update_attributes(params[:classification])
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Updated classification, #{params[:classification]}."
        format.html { redirect_to @classification, notice: 'Classification was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /classifications/1
  def destroy
    @classification = Classification.find(params[:id])
    @classification.destroy

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Destroyed classification, #{params[:classification]}."

    respond_to do |format|
      format.html { redirect_to classifications_url }
    end
  end
end
