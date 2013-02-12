class ApplicationController < ActionController::Base
  include SafeFilename
  helper :all
  protect_from_forgery

  before_filter :require_authentication, :except => [:access_denied]

  protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to :controller => 'site', :action => 'access_denied'
  end

  # Ensure session[:auth_via] exists.
  # This is populated by a whitelisted IP request, a CAS redirect or a HTTP Auth request
  def require_authentication
    return if session[:auth_via]

    # Check if the IP is whitelisted for API access (used with Sympa)
    if ApiWhitelistedIp.find_by_address(request.remote_ip)
      logger.info "API authenticated via whitelist IP: #{request.remote_ip}"
      session[:api_key] = nil
      session[:user_id] = nil
      session[:auth_via] = :whitelisted_ip
      return
    else
      logger.debug "require_authentication: Not on the API whitelist."
    end

    if session[:cas_user]
      logger.debug "require_authentication: cas_user exists in session."

      # CAS session exists. Valid user account?
      user = Person.find_by_loginid(session[:cas_user])

      if user
        # Valid user found through CAS.
        session[:api_key] = nil
        session[:user_id] = user.id
        session[:auth_via] = :cas

        logger.info "Valid CAS user is in our database. Passes authentication."

        return
      else
        # Proper CAS request but user not in our database.
        session[:api_key] = nil
        session[:user_id] = nil
        session[:auth_via] = nil

        logger.warn "Valid CAS user is denied. Not in our local database."
        flash[:error] = 'You have authenticated but are not allowed access.'

        redirect_to :controller => "site", :action => "access_denied"
      end
    else
      logger.debug "require_authentication: cas_user does not exist in session."

      # CAS session does not exist. Determine if HTTP Auth is being attempted.
      authenticate_with_http_basic { |user, password|
        key = ApiKey.find_by_secret(password)

        if key
          logger.info "API authenticated via application key"
          session[:api_key] = key
          session[:user_id] = user
          session[:auth_via] = :api_key
          return
        end

        logger.info "API authentication failed. Application key is wrong."
        # Note that they will only get 'access denied' if they supplied a name and
        # failed. If they supplied nothing for HTTP Auth, this block will get passed
        # over.
        raise ActionController::RoutingError.new('Access denied')
      }

      logger.debug "require_authentication: Nothing left to do. Redirecting to CAS."

      logger.info "session is:"
      logger.info session

      # No CAS session and did not attempt HTTP Auth. Redirect to CAS.
      CASClient::Frameworks::Rails::Filter.filter(self)
    end
  end
end
