class AdminMailer < ActionMailer::Base
  default from: "no-reply@roles.dss.ucdavis.edu"

  def sync_script_failed(email, job)
    @job = job
    logger.info "Sending sync_script_failed e-mail to #{email}..."

    @details = YAML::load(job[:handler])
    failed_script_file = @details[:sync_script].match(/\/([^\/]+)$/).captures[0]

    mail(:to => email, :subject => "Sync failure (#{failed_script_file})")
  end

  def application_error_occurred(email, message)
    @message = message
    mail(:to => email, :subject => "Application error occurred")
  end
end
