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
    session[:impersonate_id].present?
  end

  # Returns the effective user, which may differ from the actual user if
  # impersonation is taking place.
  # Differs from self.current_user, this method is 'include'd in the
  # ApplicationController and made available to CanCanCan
  def current_user
    case session[:auth_via]
    when :whitelisted_ip
      return Authentication.actual_user
    when :api_key
      return Authentication.actual_user
    when :cas
      if self.impersonating?
        return Authentication.effective_user
      else
        return Authentication.actual_user
      end
    end
  end

  def authenticated?
    session[:auth_via]
  end

  # Ensure session[:auth_via] exists.
  # This is populated by a whitelisted IP request, a CAS redirect or a HTTP Auth request
  # Main entry point for authentication procedures.
  def authenticate
    if authenticated?
      case session[:auth_via]
      when :whitelisted_ip
        Authentication.actual_user = ApiWhitelistedIpUser.find_by_address(session[:user_id])
        logger.info "Authentication passed with existing session (whitelisted IP): IP: #{session[:user_id]}"
      when :api_key
        Authentication.actual_user = ApiKeyUser.find_by_name(session[:user_id])
        logger.info "Authentication passed with existing session (API key): #{session[:user_id]}"
      when :cas
        Authentication.actual_user = Person.includes(:role_assignments, :roles, :affiliations).find_by_id(session[:user_id])
        logger.info "Authentication passed with existing session (CAS): ID: #{session[:user_id]}, login ID: #{Authentication.actual_user.loginid}"
        if self.impersonating?
          Authentication.effective_user = Person.includes(:role_assignments).includes(:roles).find_by_id(session[:impersonate_id])
          logger.info "Authentication is impersonating: ID: #{session[:impersonate_id]}, login ID: #{Authentication.effective_user.loginid}"
        end
      end

      return
    end

    @whitelisted_user = ApiWhitelistedIpUser.find_by_address(request.remote_ip)
    # Check if the IP is whitelisted for API access (used with Sympa)
    if @whitelisted_user
      logger.info "API authenticated via whitelist IP: #{request.remote_ip}"
      session[:user_id] = request.remote_ip
      session[:auth_via] = :whitelisted_ip
      Authentication.actual_user = @whitelisted_user

      @whitelisted_user.logged_in_at = DateTime.now()
      @whitelisted_user.save

      return
    end

    # Check if HTTP Auth is being attempted.
    authenticate_with_http_basic { |name, secret|
      @api_user = ApiKeyUser.find_by_name_and_secret(name, secret)

      if @api_user
        logger.info "API authenticated via application key"
        session[:user_id] = name
        session[:auth_via] = :api_key
        @api_user.logged_in_at = DateTime.now()
        @api_user.save
        Authentication.actual_user = @api_user
        return
      end

      logger.info "API authentication failed. Application key is wrong."
      # Note that they will only get 'access denied' if they supplied a name and
      # failed. If they supplied nothing for HTTP Auth, this block will get passed
      # over.
      render :text => "Invalid API key (#{name}).", :status => 401

      return
    }

    # If the environment variable _RM_DEV_LOGINID is set, force it as a CAS
    # login and bypass CAS. Useful for offline development.
    if ENV["_RM_DEV_LOGINID"]
      session[:cas_user] = ENV["_RM_DEV_LOGINID"]
    else
      # It's important we do this before checking session[:cas_user] as it
      # sets that variable. Note that the way before_filters work, this call
      # will render or redirect but this function will still finish before
      # the redirect is actually made.
      CASClient::Frameworks::Rails::Filter.filter(self)
    end
    
    if session[:cas_user]
      # CAS session exists. Valid user account?
      @user = Person.includes(:role_assignments, :roles).find_by_loginid(session[:cas_user])
      @user = nil if @user and @user.active == false # Don't allow disabled users to log in

      if @user
        # Valid user found through CAS.
        session[:user_id] = @user.id
        session[:auth_via] = :cas

        Authentication.actual_user = @user

        @user.logged_in_at = DateTime.now()
        @user.save

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
