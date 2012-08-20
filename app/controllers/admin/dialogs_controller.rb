class Admin::DialogsController < Admin::BaseController
  # GET /admin/dialogs/impersonate
  def impersonate
    respond_to do |format|
      format.html { render :partial => "impersonate", :layout => false }
    end
  end

  def ip_whitelist
    @addresses = ApiWhitelistedIp.all

    respond_to do |format|
      format.html { render :partial => "ip_whitelist", :layout => false }
    end
  end
end
