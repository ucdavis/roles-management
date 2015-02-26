class AdminMailer < ActionMailer::Base
  default from: "no-reply@roles.dss.ucdavis.edu"

  def sync_script_failed(email, job)
    @job = job
    logger.info "Sending sync_script_failed e-mail to #{email}..."
    mail(:to => email, :subject => "DSS-RM: Sync Script Failed")
  end

  def application_error_occurred(email, message)
    @message = message
    mail(:to => email, :subject => "DSS-RM: Application error occurred")
  end
end
