class TemplateAssignmentController < ApplicationController
  filter_access_to :all
  
  # POST /templates/assign.json
  def create
    @ta = TemplateAssignment.new(params[:template_assignment])

    respond_to do |format|
      if @ta.save
        format.json { render json: @ta, status: :created, location: @ta }
      else
        format.json { render json: @ta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/unassign.json
  def destroy
    @ta = TemplateAssignment.find(params[:template_assignment_id])
    @ta.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
