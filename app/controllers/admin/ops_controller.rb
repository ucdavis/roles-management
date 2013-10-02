# Misc. admin operations controller
class Admin::OpsController < Admin::BaseController
  filter_access_to :all, :attribute_check => false

  # GET /admin/ops/impersonate/[loginid]
  def impersonate
    @person = Person.find_by_loginid(params[:loginid])

    unless @person.nil?
      logger.info "#{actual_user.log_identifier}@#{request.remote_ip}: Impersonating #{params[:loginid]}."
      session[:impersonation_id] = @person.id
    end

    redirect_to applications_url
  end

  def unimpersonate
    logger.info "#{actual_user.log_identifier}@#{request.remote_ip}: Un-impersonating #{session[:impersonation_id]}."

    session.delete(:impersonation_id)

    redirect_to applications_url
  end

  def ad_path_check
    require 'active_directory_wrapper'

    respond_to do |format|
      format.json { render :json => { exists: ActiveDirectoryWrapper.group_exists?(params[:path]) } }
    end
  end
end
