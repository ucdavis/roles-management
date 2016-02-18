class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  include SafeFilename
  helper :all
  protect_from_forgery with: :exception
  after_action :verify_authorized

  before_filter :authenticate

  rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActionController::InvalidAuthenticityToken, ActionController::RoutingError, ActiveRecord::RecordNotDestroyed do |exception|
    unless exception.class == ActiveRecord::RecordNotFound
      log_message = "An exception occurred:\n\n#{exception}\n\n" + exception.backtrace.join('\n')
      logger.error log_message
      
      AdminMailer.application_error_occurred("dssit-devs-exceptions@ucdavis.edu", log_message).deliver!
    end

    raise exception
  end

  protected

    def permission_denied
        if session[:auth_via] == :cas
        # Human-facing error
        flash[:error] = "Sorry, you are not allowed to access that page."
        redirect_to access_denied_path
        else
        # Machine-facing error
        render :text => "Permission denied.", :status => 403
        end
    end
end
