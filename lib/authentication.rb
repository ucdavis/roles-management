module Authentication
  # Returns the current_user, which may be 'false' if impersonation is active
  def current_user
    if session[:impersonate]
      Person.find_by_loginid(session[:impersonate])
    else
      case session[:auth_via]
      when :whitelisted_ip
        return ApiWhitelistedIpUser.find_by_address(session[:user_id])
      when :api_key
        return ApiKeyUser.find_by_name(session[:user_id])
      when :cas
        return Person.find_by_id(session[:user_id])
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
  def require_authentication
    if session[:auth_via]
      case session[:auth_via]
      when :whitelisted_ip
        Authorization.current_user = ApiWhitelistedIpUser.find_by_address(session[:user_id])
      when :api_key
        Authorization.current_user = ApiKeyUser.find_by_name(session[:user_id])
      when :cas
        Authorization.current_user = Person.find_by_id(session[:user_id])
      end
      logger.info "User authentication passed due to existing session: #{session[:auth_via]}, #{Authorization.current_user}"
      return
    end

    @whitelisted_user = ApiWhitelistedIpUser.find_by_address(request.remote_ip)
    # Check if the IP is whitelisted for API access (used with Sympa)
    if @whitelisted_user
      logger.info "API authenticated via whitelist IP: #{request.remote_ip}"
      session[:user_id] = request.remote_ip
      session[:auth_via] = :whitelisted_ip
      Authorization.current_user = @whitelisted_user
      return
    else
      logger.debug "require_authentication: Not on the API whitelist."
    end

    # Check if HTTP Auth is being attempted.
    authenticate_with_http_basic { |name, secret|
      @api_user = ApiKeyUser.find_by_name_and_secret(name, secret)

      if @api_user
        logger.info "API authenticated via application key"
        session[:user_id] = name
        session[:auth_via] = :api_key
        Authorization.current_user = @api_user
        return
      end

      logger.info "API authentication failed. Application key is wrong."
      # Note that they will only get 'access denied' if they supplied a name and
      # failed. If they supplied nothing for HTTP Auth, this block will get passed
      # over.
      render :text => "Invalid API key.", :status => 401
      return
      #raise ActionController::RoutingError.new('Access denied')
    }

    logger.debug "Passed over HTTP Auth."

    # It's important we do this before checking session[:cas_user] as it
    # sets that variable. Note that the way before_filters work, this call
    # will render or redirect but this function will still finish before
    # the redirect is actually made.
    CASClient::Frameworks::Rails::Filter.filter(self)

    if session[:cas_user]
      logger.debug "require_authentication: cas_user exists in session."

      # CAS session exists. Valid user account?
      @user = Person.find_by_loginid(session[:cas_user])

      if @user
        # Valid user found through CAS.
        session[:user_id] = @user.id
        session[:auth_via] = :cas
        Authorization.current_user = @user

        logger.info "Valid CAS user is in our database. Passes authentication."

        return
      else
        # Proper CAS request but user not in our database.
        session[:user_id] = nil
        session[:auth_via] = nil

        logger.warn "Valid CAS user is denied. Not in our local database."
        flash[:error] = 'You have authenticated but are not allowed access.'

        redirect_to :controller => "site", :action => "access_denied"
      end
    end
  end

  # Returns true if we're currently impersonating another user
  def impersonating?
    session[:impersonate] ? true : false
  end
end
