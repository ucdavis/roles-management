class EntitiesController < ApplicationController
  include DatabaseExtensions
  
  before_filter :new_entity_from_params, :only => :create
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => true, :load_method => :load_entities
  respond_to :json

  def index
    respond_with @entities
  end

  def show
    @entity = Entity.find(params[:id])

    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded group page for #{params[:id]}."

    respond_with @entity do |format|
      format.json
      format.csv {
        require 'csv'

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = CSV.generate do |csv|
          csv << Person.csv_header
          @entity.flattened_members.each do |m|
            csv << m.to_csv
          end
        end
        send_data csv_data,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=" + unix_filename("#{@entity.name}")
      }
    end
  end

  def create
    @entity.save

    if params[:entity][:type] == "Group"
      @entity.owners << current_user
    end

    respond_with @entity
  end

  def update
    # declarative_authorization requires we not use polymorphism *headache*
    if params[:entity][:type] == "Group"
      @entity = Group.with_permissions_to(:update).find(params[:id])
    elsif params[:entity][:type] == "Person"
      @entity = Person.with_permissions_to(:update).find(params[:id])
    end

    @entity.update_attributes(params[:entity])
    
    # Overridden to respond with the object and not a '204 No Content'.
    # See: http://stackoverflow.com/questions/9953887/simple-respond-with-in-rails-that-avoids-204-from-put
    respond_with(@entity) do |format|
      format.json{ render json: @entity }
    end
  end

  def destroy
    entity = Entity.find(params[:id])

    if entity.type == "Group"
      logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Deleted entity, #{entity}."

      entity.destroy

      render :nothing => true
    end
  end
  
  protected
  
  def new_entity_from_params
    # Only allow "Group" and "Person" to be constantized for security
    if (params[:entity][:type] == "Group") || (params[:entity][:type] == "Person")
      @entity = params[:entity][:type].constantize.new(params[:entity])
    else
      @entity = nil
    end
  end
  
  private
  
  def load_entities
    if params[:q]
      upper_q = params[:q].upcase
      # Note: we search login IDs here too in case somebody is doing an entity-search but wants to find people by login ID
      @entities = Entity.where("upper(first) like ? or upper(last) like ? or upper(" + db_concat(:first, ' ', :last) + ") like ? or upper(name) like ? or upper(loginid) like ?", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%")
    else
      @entities = Entity.all
    end
  end
end
