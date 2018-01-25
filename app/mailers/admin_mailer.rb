class AdminMailer < ActionMailer::Base
  default from: ENV['SMTP_FROM_ADDRESS'] || Rails.application.secrets['smtp_from_address']

  def sync_script_failed(email, job)
    @job = job
    logger.info "Sending sync_script_failed e-mail to #{email}..."

    @details = YAML::safe_load(job[:handler])
    failed_script_file = @details[:sync_script].match(/\/([^\/]+)$/).captures[0]

    mail(to: email, subject: "Sync failure (#{failed_script_file})")
  end

  def application_error_occurred(recipient, message)
    @message = message
    mail(to: recipient, subject: 'Application error occurred')
  end
end
