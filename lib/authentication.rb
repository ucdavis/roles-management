module Authentication
  class Error < StandardError; end

  # effective_user = Will return impersonated user if any, else 'actual' user
  # (the admin who might be impersonating)
  # actual_user    = Always the actual user regardless of whether impersonation
  # is being used (i.e. returns the admin doing the impersonating)
  # Outside code should just call 'current_user'

  # This will be set if and only if somebody is impersonating
  def self.effective_user
    Thread.current["_auth_effective_user"] || nil
  end

  def self.effective_user=(user)
    Thread.current["_auth_effective_user"] = user
  end

  # Set this to the actual user
  def self.actual_user
    Thread.current["_auth_actual_user"] || nil
  end

  def self.actual_user=(user)
    Thread.current["_auth_actual_user"] = user

    # Remove the following line once declarative_authorization is
    # factored out.
    Authorization.current_user = user
  end

  # To be called from the outside in order to impersonate someone
  def auth_impersonate(id)
    session[:impersonate_id] = id
  end

  # Removes any impersonation
  def auth_unimpersonate
    session.delete(:impersonate_id)
  end

  def impersonating?
    session[:impersonate_id]
  end

  # Returns the effective user, which may differ from the actual user if
  # impersonation is taking place.
  # Differs from self.current_user, this method is 'include'd in the
  # ApplicationController and made available to CanCanCan
  def current_user
    logger.debug "current_user called"

    case session[:auth_via]
    when :whitelisted_ip
      logger.debug "auth_via is :whitelisted_ip"
      return ApiWhitelistedIpUser.find_by_address(session[:user_id])
    when :api_key
      logger.debug "auth_via is :api_key"
      return ApiKeyUser.find_by_name(session[:user_id])
    when :cas
      logger.debug "auth_via is :cas"
      if self.impersonating?
        logger.debug "impersonating so returning effective_user (#{Authentication.effective_user})"
        return Authentication.effective_user
      else
        logger.debug "not impersonating so returning actual_user (#{Authentication.actual_user})"
        return Authentication.actual_user
      end
    end
    # end
  end

  def authenticated?
    session[:auth_via]
  end

  # Wrapper methods to abstract CanCan, declarative_authorization
  def disable_authorization
    Authorization.ignore_access_control(true)
  end

  def enable_authorization
    Authorization.ignore_access_control(false)
  end

  # Wrapper for disable_authorization -> block -> enable_authorization as
  # this is a common pattern.
  def without_authorization
    disable_authorization
    yield
    enable_authorization
  end

  # Ensure session[:auth_via] exists.
  # This is populated by a whitelisted IP request, a CAS redirect or a HTTP Auth request
  # Main entry point for authentication procedures.
  def authenticate
    if authenticated?
      case session[:auth_via]
      when :whitelisted_ip
        Authentication.actual_user = ApiWhitelistedIpUser.find_by_address(session[:user_id])
      when :api_key
        Authentication.actual_user = ApiKeyUser.find_by_name(session[:user_id])
      when :cas
        logger.debug "auth_via is :cas, setting actual_user to #{session[:user_id]}"
        Authentication.actual_user = Person.includes(:role_assignments).includes(:roles).includes(:affiliations).find_by_id(session[:user_id])
        if self.impersonating?
          logger.debug "impersonating? is true. Also setting effective_user to #{session[:impersonate_id]}"
          Authentication.effective_user = Person.includes(:role_assignments).includes(:roles).find_by_id(session[:impersonate_id])
        end
      end
      logger.info "User authentication passed due to existing session: #{session[:auth_via]}, #{session[:user_id]}, #{Authorization.current_user}"
      return
    end

    @whitelisted_user = ApiWhitelistedIpUser.find_by_address(request.remote_ip)
    # Check if the IP is whitelisted for API access (used with Sympa)
    if @whitelisted_user
      logger.info "API authenticated via whitelist IP: #{request.remote_ip}"
      session[:user_id] = request.remote_ip
      session[:auth_via] = :whitelisted_ip
      Authentication.actual_user = @whitelisted_user

      without_authorization do
        @whitelisted_user.logged_in_at = DateTime.now()
        @whitelisted_user.save
      end

      return
    end

    # Check if HTTP Auth is being attempted.
    authenticate_with_http_basic { |name, secret|
      @api_user = ApiKeyUser.find_by_name_and_secret(name, secret)

      if @api_user
        logger.info "API authenticated via application key"
        session[:user_id] = name
        session[:auth_via] = :api_key
        Authentication.actual_user = @api_user
        Authorization.ignore_access_control(true)
        @api_user.logged_in_at = DateTime.now()
        @api_user.save
        Authorization.ignore_access_control(false)
        return
      end

      logger.info "API authentication failed. Application key is wrong."
      # Note that they will only get 'access denied' if they supplied a name and
      # failed. If they supplied nothing for HTTP Auth, this block will get passed
      # over.
      render :text => "Invalid API key.", :status => 401

      return
    }

    logger.debug "Passed over HTTP Auth."

    # It's important we do this before checking session[:cas_user] as it
    # sets that variable. Note that the way before_filters work, this call
    # will render or redirect but this function will still finish before
    # the redirect is actually made.
    CASClient::Frameworks::Rails::Filter.filter(self)

    if session[:cas_user]
      logger.debug "cas_user is set in session, attempting CAS-based authentication"

      # CAS session exists. Valid user account?
      @user = Person.includes(:role_assignments).includes(:roles).find_by_loginid(session[:cas_user])
      @user = nil if @user and @user.active == false # Don't allow disabled users to log in

      if @user
        # Valid user found through CAS.
        session[:user_id] = @user.id
        session[:auth_via] = :cas

        Authentication.actual_user = @user

        Authorization.ignore_access_control(true)
        @user.logged_in_at = DateTime.now()
        @user.save
        Authorization.ignore_access_control(false)

        # They are a valid @user but have no roles, so redirect them to access_denied
        unless @user.role_symbols.length > 0
          logger.info "Valid CAS user (#{@user.loginid}) is in our database but has no roles. Fails authentication."
          redirect_to access_denied_path
          return
        end

        logger.info "Valid CAS user (#{@user.loginid}) is in our database and has proper roles. Passes authentication."
        ActivityLog.record!("Logged in.", ["person_#{@user.id}"])

        if params[:ticket] and params[:ticket].include? "cas"
          # This is a session-initiating CAS login, so remove the damn GET parameter from the URL for UX
          redirect_to :controller => params[:controller], :action => params[:action]
        end

        return
      else
        # Proper CAS request but user not in our database.
        session[:user_id] = nil
        session[:auth_via] = nil

        logger.info "Valid CAS user (#{session[:cas_user]}) is not in our database. Fails authentication."
        flash[:error] = 'You have authenticated but are not allowed access.'

        redirect_to :controller => "site", :action => "access_denied"
      end
    end
  end
end
