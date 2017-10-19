module Api
  module V1
    class PeopleController < Api::V1::BaseController
      before_action :load_person, only: :show

      def show
        if @person && @person.active
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid}." }

          @cache_key = "api/person/#{@person.loginid}/#{@person.updated_at.try(:utc).try(:to_s, :number)}"

          render 'api/v1/people/show'
        elsif @person and @person.active == false
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid} but person is disabled. Returning 404." }
          render json: '', status: 404
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load person view (show) for invalid ID #{@params_id}." }
          render plain: "Invalid person ID '#{@params_id}'.", status: 404
        end
      end

      def import
        if params[:loginid]
          person = LdapPersonHelper.create_or_update_person_by_loginid(params[:loginid], Rails.logger)

          if person
            respond_to do |format|
              format.json { render json: person }
            end
          else
            logger.error "Could not import person #{params[:loginid]}, no results from LDAP."

            respond_to do |format|
              format.json { render json: "Could not import person #{params[:loginid]}, no results from LDAP.", status: 404 }
            end
          end
        else
          logger.error 'Invalid request for LDAP person import. Did not specify loginid.'

          respond_to do |format|
            format.json { render json: nil, status: 400 }
          end
        end
      end

      private

      def load_person
        @params_id = CGI::escapeHTML(params[:id])
        @person = Person.find_by_loginid(@params_id)
        @person = Person.find_by_id(@params_id) unless @person
      rescue ActiveRecord::RecordNotFound
        # This exception is acceptable. We catch it to avoid triggering the
        # uncaught exceptions handler in ApplicationController.
      end
    end
  end
end
