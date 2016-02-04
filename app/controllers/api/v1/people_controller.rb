module Api
  module V1
    class PeopleController < ApplicationController
      before_filter :load_person, :only => :show
      filter_access_to :all, :attribute_check => false

      def show
        if @person and @person.active
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid}." }

          @cache_key = "api/person/" + @person.loginid + '/' + @person.updated_at.try(:utc).try(:to_s, :number)

          render "api/v1/people/show"
        elsif @person and @person.active == false
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid} but person is disabled. Returning 404." }
          render :json => "", :status => 404
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load person view (show) for invalid ID #{@params_id}." }
          render :text => "Invalid person ID '#{@params_id}'.", :status => 404
        end
      end

      private

      def load_person
        begin
          @params_id = CGI::escapeHTML(params[:id])
          @person = Person.with_permissions_to(:read).find_by_loginid(@params_id)
          @person = Person.with_permissions_to(:read).find_by_id(@params_id) unless @person
        rescue ActiveRecord::RecordNotFound
          # This exception is acceptable. We catch it to avoid triggering the
          # uncaught exceptions handler in ApplicationController.
        end
      end
    end
  end
end
