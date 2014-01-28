module Api
  module V1
    class PeopleController < ApplicationController
      before_filter :load_person, :only => :show
      filter_access_to :all, :attribute_check => true

      def show
        if @person and @person.active
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid}." }
          render "api/v1/people/show"
        elsif @person and @person.active == false
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid} but person is disabled. Returning 404." }
          render :json => "", :status => 404
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load person view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid person ID '#{params[:id]}'.", :status => 404
        end
      end
  
      private
  
      def load_person
        @person = Person.with_permissions_to(:read).find_by_loginid(params[:id])
        @person = Person.with_permissions_to(:read).find_by_id(params[:id]) unless @person
      end
    end
  end
end
