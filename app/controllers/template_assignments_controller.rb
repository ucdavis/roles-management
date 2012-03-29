class TemplateAssignmentsController < ApplicationController
  filter_access_to :all
  
  # POST /templates/assign.json
  def create
    @ta = TemplateAssignment.new(params[:template_assignment])

    respond_to do |format|
      if @ta.save
        format.json { render json: @ta, status: :created }
      else
        format.json { render json: @ta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/unassign.json
  def destroy
    @ta = TemplateAssignment.find_by_person_id_and_template_id(params[:template_assignment][:person_id], params[:template_assignment][:template_id])
    @ta.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
