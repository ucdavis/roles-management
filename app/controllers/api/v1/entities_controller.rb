module Api
  module V1
    class EntitiesController < ApplicationController
      filter_access_to :all, :attribute_check => true
      before_filter :load_person, :only => :show
      filter_access_to :index, :attribute_check => true, :load_method => :load_entities
      respond_to :json

      def index
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched entities index." }
        
        render "api/v1/entities/index"
      end
      
      def show
        if @entity
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity view (show) for #{@entity.id}." }
          render "api/v1/entities/show"
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load entity view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid entity ID '#{params[:id]}'.", :status => 404
        end
      end

      private
  
      def load_entities
        if params[:q]
          entities_table = Entity.arel_table
      
          # Search login IDs in case of an entity-search but looking for person by login ID
          @entities = Entity.with_permissions_to(:read).where(entities_table[:name].matches("%#{params[:q]}%").or(entities_table[:loginid].matches("%#{params[:q]}%")).or(entities_table[:first].matches("%#{params[:q]}%")).or(entities_table[:last].matches("%#{params[:q]}%")))
        else
          @entities = Entity.with_permissions_to(:read).all
        end
      end
    end
  end
end
