module Api
  module V1
    class PeopleController < ApplicationController
      include DatabaseExtensions
      before_filter :load_person, :only => :show
      filter_access_to :all, :attribute_check => true
      filter_access_to :index, :attribute_check => true, :load_method => :load_people
      respond_to :json

      # Used by the API and various Person-only token inputs
      # Takes optional 'q' parameter to filter index
      # def index
      #   respond_with @people
      # end

      def show
        if @person
          logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded person view (show) for #{@person.loginid}."
          render "api/v1/people/show"
        else
          logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load person view (show) for invalid ID #{params[:id]}."
          render :text => "Invalid person ID '#{params[:id]}'.", :status => 404
        end
      end
  
      # def update
      #   if params[:id] and params[:person]
      #     @person = Person.find(params[:id])
      #     @person.update_attributes(params[:person].except(:id, :name, :roles))
      # 
      #     respond_with @person
      #   else
      #     respond_with 422
      #   end
      # end
  
      private
  
      def load_person
        @person = Person.find_by_loginid(params[:id])
        @person = Person.find_by_id(params[:id]) unless @person
      end
  
      # def load_people
      #   if params[:q]
      #     people_table = Person.arel_table
      #     @people = Person.with_permissions_to(:read).where(people_table[:name].matches("%#{params[:q]}%").or(people_table[:loginid].matches("%#{params[:q]}%")).or(people_table[:first].matches("%#{params[:q]}%")).or(people_table[:last].matches("%#{params[:q]}%")))
      # 
      #     @people.map()
      #   else
      #     @people = Person.all
      #   end
      # end
    end
  end
end
