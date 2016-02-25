class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  include SafeFilename
  helper :all
  protect_from_forgery with: :exception
  after_action :verify_authorized

  before_filter :authenticate
  
  rescue_from Pundit::NotAuthorizedError do |exception|
    permission_denied
  end

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
      flash[:error] = "You do not have permission to access that page."
      # Machine-facing error
      respond_to do |format|
        format.html { redirect_to access_denied_path }
        format.text { render "Permission denied.", status: 403 }
        format.json { render json: {}, status: :forbidden }
      end
    end
end
