# Misc. admin operations controller
class Admin::OpsController < Admin::BaseController
  # GET /admin/ops/impersonate/[loginid]
  def impersonate
    @person = Person.find_by_loginid(params[:loginid])

    unless @person.nil?
      logger.info "#{actual_user.loginid}@#{request.remote_ip}: Impersonating #{params[:loginid]}."
      session[:impersonate] = params[:loginid]
    end

    redirect_to root_url
  end

  def unimpersonate
    logger.info "#{actual_user.loginid}@#{request.remote_ip}: Un-impersonating #{session[:impersonate]}."

    session.delete(:impersonate)

    redirect_to root_url
  end
end
