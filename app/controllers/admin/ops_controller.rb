# Misc. admin operations controller
class Admin::OpsController < Admin::BaseController
  # GET /admin/ops/impersonate/[loginid]
  def impersonate
    authorize :ops, :impersonate?
  
    @person = Person.find_by_loginid(params[:loginid])

    unless @person.nil?
      logger.info "#{Authentication.actual_user.log_identifier}@#{request.remote_ip}: Impersonating #{params[:loginid]}."

      auth_impersonate(@person.id)
    end

    redirect_to applications_url
  end

  def unimpersonate
    authorize :ops, :unimpersonate?
  
    logger.info "#{Authentication.actual_user.log_identifier}@#{request.remote_ip}: Un-impersonating #{session[:impersonation_id]}."

    auth_unimpersonate

    redirect_to applications_url
  end
end
