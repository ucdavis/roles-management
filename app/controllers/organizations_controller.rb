class OrganizationsController < ApplicationController
  before_action :load_organizations, only: :index
  before_action :load_organization, only: :show

  # GET /organizations.json
  # It's assumed that organizations are never scoped per-user or per-permission. If this
  # changes, the @cache_key must change to reflect such scoped nature.
  def index
    authorize Organization

    @cache_key = "organization/" + (params[:q] ? params[:q] : '') + '/' + Digest::MD5.hexdigest(@organizations.map(&:cache_key).to_s) + params[:tree].to_s + params[:q].to_s

    if params[:tree]
      Rails.logger.debug "Rendering organization index tree"
      respond_to do |format|
        format.json { render "organizations/index_tree" }
      end
    else
      Rails.logger.debug "Rendering organization index (non-tree)"
      respond_to do |format|
        format.json { render "organizations/index" }
      end
    end
  end

  # GET /organizations/1.json
  def show
    authorize @organization
  
    respond_to do |format|
      format.json { render json: @organization }
    end
  end

  private

    def load_organization
      @organization = Organization.find_by_id!(params[:id])
    end

    def load_organizations
      if params[:q]
        organizations_table = Organization.arel_table

        # Search login IDs in case of an entity-search but looking for person by login ID
        @organizations = Organization.where(organizations_table[:name].matches("%#{params[:q]}%").or(organizations_table[:dept_code].matches("%#{params[:q]}%")))

        logger.debug "Organizations#index searching for '#{params[:q]}'. Found #{@organizations.length} results."
      else
        @organizations = Organization.all

        if params[:tree]
          @top_level_organizations = []

          @organizations.each do |organization|
            if organization.parent_organizations.length == 0
              @top_level_organizations << organization
            end
          end
        end
      end
    end
end
