class AdminMailer < ActionMailer::Base
  default from: "no-reply@roles.dss.ucdavis.edu"

  # def ldap_report(email, log)
  #   @log = log
  #   logger.info "Sending LDAP Report e-mail to #{email}..."
  #   mail(:to => email, :subject => "DSS-RM: LDAP Import Report for %s" % [Time.now.strftime("%A %B %d, %Y")])
  # end

  def sync_script_failed(email, job)
    @job = job
    logger.info "Sending sync_script_failed e-mail to #{email}..."
    mail(:to => email, :subject => "DSS-RM: Sync Script Failed")
  end
end
