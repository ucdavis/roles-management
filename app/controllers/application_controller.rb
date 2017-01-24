class ApplicationController < ActionController::Base
  include Authentication
  include Pundit
  include SafeFilename
  helper :all
  before_filter :authenticate
  # Avoid the CSRF check if CAS is doing a single sign-out. In Rails 5, the order of the filter should be respected.
  # See http://blog.bigbinary.com/2016/04/06/rails-5-default-protect-from-forgery-prepend-false.html
  protect_from_forgery with: :exception, :unless => Proc.new {|c| c.request.params.include?('logoutRequest') }
  after_action :verify_authorized
  
  rescue_from Pundit::NotAuthorizedError do |exception|
    permission_denied
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ActionController::InvalidAuthenticityToken, ActionController::RoutingError, ActiveRecord::RecordNotDestroyed do |exception|
    log_message = "An exception occurred:\n\n#{exception}\n\n" + exception.backtrace.join('\n')
    logger.error log_message
    
    AdminMailer.application_error_occurred("dssit-devs-exceptions@ucdavis.edu", log_message).deliver_now!

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
