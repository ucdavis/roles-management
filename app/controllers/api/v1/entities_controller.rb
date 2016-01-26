module Api
  module V1
    class EntitiesController < ApplicationController
      filter_access_to :all, :attribute_check => true
      before_filter :load_entity, :only => :show
      filter_access_to :index, :attribute_check => true, :load_method => :load_entities

      def index
        logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched entities index." }

        @cache_key = "api/entity/" + (params[:q] ? params[:q] : '') + '/' + @entities.max_by(&:updated_at).to_s

        respond_to do |format|
          format.json { render "api/v1/entities/index" }
        end
      end

      def show
        if @entity and @entity.active
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity view (show) for #{@entity.id}." }

          @cache_key = "api/entity/" + @entity.id.to_s + '/' + @entity.updated_at.try(:utc).try(:to_s, :number)

          respond_to do |format|
            format.json { render "api/v1/entities/show" }
          end
        elsif @entity and @entity.active == false
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded entity view (show) for #{@entity.id} but entity is disabled. Returning 404." }
          respond_to do |format|
            format.json { render :json => "", :status => 404 }
          end
        else
          logger.tagged('API') { logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Attempted to load entity view (show) for invalid ID #{params[:id]}." }
          respond_to do |format|
            format.text { render :text => "Invalid entity ID '#{params[:id]}'.", :status => 404 }
          end
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
          @entities = Entity.with_permissions_to(:read).where(:active => true)#.all
        end
      end
    end
  end
end
