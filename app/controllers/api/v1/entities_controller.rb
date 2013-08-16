module Api
  module V1
    class EntitiesController < ApplicationController
      include DatabaseExtensions
  
      filter_access_to :all, :attribute_check => true
      filter_access_to :index, :attribute_check => true, :load_method => :load_entities
      respond_to :json

      def index
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded or searched entities index."
        
        render "api/v1/entities/index"
      end

      private
  
      def load_entities
        if params[:q]
          entities_table = Entity.arel_table
      
          # Search login IDs in case of an entity-search but looking for person by login ID
          @entities = Entity.with_permissions_to(:read).where(entities_table[:name].matches("%#{params[:q]}%").or(entities_table[:loginid].matches("%#{params[:q]}%")).or(entities_table[:first].matches("%#{params[:q]}%")).or(entities_table[:last].matches("%#{params[:q]}%")))
        else
          @entities = Entity.all
        end
      end
    end
  end
end
