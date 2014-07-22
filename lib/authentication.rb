module Authentication
  # Returns the current_user, which may be 'false' if impersonation is active
  def current_user
    if impersonating?
      return Authorization.current_user
    else
      case session[:auth_via]
      when :whitelisted_ip
        return ApiWhitelistedIpUser.find_by_address(session[:user_id])
      when :api_key
        return ApiKeyUser.find_by_name(session[:user_id])
      when :cas
        return Authorization.current_user
      end
    end
  end

  # Returns the 'actual' user - usually this matches current_user but when
  # impersonating, it will return the human doing the impersonating, not the
  # account they are pretending to be. Useful for determining if actions like
  # 'un-impersonate' should be made available.
  def actual_user
    Person.find_by_id(session[:user_id])
  end

  # Ensure session[:auth_via] exists.
  # This is populated by a whitelisted IP request, a CAS redirect or a HTTP Auth request
  def authenticate
    if session[:auth_via]
      case session[:auth_via]
      when :whitelisted_ip
        Authorization.current_user = ApiWhitelistedIpUser.find_by_address(session[:user_id])
      when :api_key
        Authorization.current_user = ApiKeyUser.find_by_name(session[:user_id])
      when :cas
        if impersonating?
          Authorization.current_user = Person.includes(:role_assignments).includes(:roles).find_by_id(session[:impersonation_id])
        else
          Authorization.current_user = Person.includes(:role_assignments).includes(:roles).includes(:affiliations).find_by_id(session[:user_id])
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
      Authorization.current_user = @whitelisted_user

      Authorization.ignore_access_control(true)
      @whitelisted_user.logged_in_at = DateTime.now()
      @whitelisted_user.save
      Authorization.ignore_access_control(false)
      return
    else
      logger.debug "authenticate: Not on the API whitelist."
    end

    # Check if HTTP Auth is being attempted.
    authenticate_with_http_basic { |name, secret|
      @api_user = ApiKeyUser.find_by_name_and_secret(name, secret)

      if @api_user
        logger.info "API authenticated via application key"
        session[:user_id] = name
        session[:auth_via] = :api_key
        Authorization.current_user = @api_user
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
        Authorization.current_user = @user
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

  # Returns true if we're currently impersonating another user
  def impersonating?
    session[:impersonation_id] ? true : false
  end
end
