module Api
  module V1
    class EntitiesController < ApplicationController
      filter_access_to :all, :attribute_check => true
      before_filter :load_entity, :only => :show
      filter_access_to :index, :attribute_check => true, :load_method => :load_entities
      respond_to :json

      def index
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched entities index." }
        
        @cache_key = Digest::MD5.hexdigest(@entities.map(&:cache_key).to_s)
        
        render "api/v1/entities/index"
      end
      
      def show
        if @entity and @entity.active
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity view (show) for #{@entity.id}." }
          render "api/v1/entities/show"
        elsif @entity and @entity.active == false
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity view (show) for #{@entity.id} but entity is disabled. Returning 404." }
          render :json => "", :status => 404
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load entity view (show) for invalid ID #{params[:id]}." }
          render :text => "Invalid entity ID '#{params[:id]}'.", :status => 404
        end
      end

      private

      def load_entity
        @entity = Entity.with_permissions_to(:read).find_by_id(params[:id])
      end
  
      def load_entities
        if params[:q]
          entities_table = Entity.arel_table
      
          # Search login IDs in case of an entity-search but looking for person by login ID
          @entities = Entity.with_permissions_to(:read).where(:active => true).where(entities_table[:name].matches("%#{params[:q]}%").or(entities_table[:loginid].matches("%#{params[:q]}%")).or(entities_table[:first].matches("%#{params[:q]}%")).or(entities_table[:last].matches("%#{params[:q]}%")))
        else
          @entities = Entity.with_permissions_to(:read).where(:active => true).all
        end
      end
    end
  end
end
