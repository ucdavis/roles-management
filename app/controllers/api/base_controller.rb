class Api::BaseController < ApplicationController
  before_filter :api_authenticate

  # Returns method of API access for the current request
  # Valid responses are :api_key, :cas_user, :whitelisted_ip, or :none
  # :none indicates they have not authenticated.
  def authenticated_via?
    @authenticated_via
  end

  protected

  # API authentication is available via CAS, an IP whitelist, and HTTP basic auth
  def api_authenticate
    @authenticated_via = :none

    if session[:cas_user].nil?
      # Check if the IP is whitelisted for API access (needed for Sympa)
      if ApiWhitelistedIp.find_by_address(request.remote_ip)
        logger.info "API authenticated via whitelist IP: #{request.remote_ip}"
        session[:api_key] = nil
        @authenticated_via = :whitelisted_ip
        return true
      end

      authenticate_or_request_with_http_basic do |username, password|
        key = ApiKey.find_by_secret(password)

        if key
          logger.info "API authenticated via application key"
          session[:api_key] = key
          @authenticated_via = :api_key
          return true
        end

        logger.info "API authentication failed. Application key is wrong."
        raise ActionController::RoutingError.new('Access denied')

        return false
      end
    else
      logger.info "API authentication allowed via CAS."
      session[:api_key] = nil
      @authenticated_via = :cas_user
      return true
    end
  end

  # db_concat is from http://stackoverflow.com/questions/2986405/database-independant-sql-string-concatenation-in-rails
  # Symbols should be used for field names, everything else will be quoted as a string
  def db_concat(*args)
    adapter = ActiveRecord::Base.connection.instance_values["config"][:adapter] #configurations[RAILS_ENV]['adapter'].to_sym
    args.map!{ |arg| arg.class==Symbol ? arg.to_s : "'#{arg}'" }

    case adapter
      when :mysql
        "CONCAT(#{args.join(',')})"
      when :sqlserver
        args.join('+')
      else
        args.join('||')
    end
  end
end
