class Api::BaseController < ApplicationController
  before_filter :api_authenticate

  protected

  def api_authenticate
    @application = nil
    
    if session[:cas_user].nil?
      authenticate_or_request_with_http_basic do |username, password|
        @application = Application.find_by_name(username)

        if @application.nil? == false
          # Application exists
          if @application.api_key == password
            session[:current_application] = @application
            return true
          end
        end

        raise ActionController::RoutingError.new('Access denied')

        return false
      end
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
