class Api::BaseController < ApplicationController
  before_filter :api_authenticate

  protected

  def api_authenticate
    @application = nil

    if session[:cas_user].nil?
      authenticate_or_request_with_http_basic do |username, password|
        key = ApiKey.find_by_secret(password)

        if key
          logger.info "API authenticated via application key"
          session[:api_key] = key
          return true
        end

        logger.info "API authentication failed. Application key is wrong."
        raise ActionController::RoutingError.new('Access denied')

        return false
      end
    else
      logger.info "API authentication allowed via CAS."
      session[:api_key] = nil
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
