class EntitiesController < ApplicationController
  include DatabaseExtensions
  filter_access_to :all
  respond_to :json

  def index
    # SECUREME
    if params[:q]
      upper_q = params[:q].upcase
      @entities = Entity.where("upper(first) like ? or upper(last) like ? or upper(" + db_concat(:first, ' ', :last) + ") like ? or upper(name) like ?", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%", "%#{upper_q}%")
    else
      @entities = Entity.all
    end

    respond_with @entities
  end

  def show
    # SECUREME
    @entity = Entity.find(params[:id])

    logger.info "#{current_user.loginid}@#{request.remote_ip}: Loaded group page for #{params[:id]}."

    respond_with @entity do |format|
      format.json #{ render json: @group }
      format.csv {
        require 'csv'

        # Credit CSV code: http://www.funonrails.com/2012/01/csv-file-importexport-in-rails-3.html
        csv_data = CSV.generate do |csv|
          csv << Person.csv_header
          @entity.members(flatten = true).each do |m|
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
    # SECUREME
    # Only allow "Group" and "Person" to be constantized for security
    if (params[:entity][:type] == "Group") || (params[:entity][:type] == "Person")
      @entity = params[:entity][:type].constantize.new(params[:entity])

      @entity.save

      if params[:entity][:type] == "Group"
        @entity.owners << current_user
      end

      render "entities/show"
    end
  end

  def update
    # SECUREME
    @entity = Entity.find(params[:id])

    @entity.update_attributes(params[:entity])
    render "show"
  end

  def destroy
    # SECUREME
    entity = Entity.find(params[:id])

    if entity.type == "Group"
      if entity.owners.include? current_user
        logger.info "#{current_user.loginid}@#{request.remote_ip}: Deleted entity, #{entity}."

        # Must own the group to delete it
        entity.destroy

        render :nothing => true
      else
        render :status => :forbidden
      end
    end
  end
end
