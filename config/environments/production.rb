DSSRM::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests.
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # Attempt to read encrypted secrets from `config/secrets.yml.enc`.
  # Requires an encryption key in `ENV["RAILS_MASTER_KEY"]` or
  # `config/secrets.yml.key`.
  config.read_encrypted_secrets = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # For nginx:
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # See everything in the log (default is :info)
  config.log_level = :info

  config.cache_store = :memory_store, { size: 64.megabytes } #:dalli_store #:mem_cache_store, "localhost"

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_files = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"
  config.action_mailer.perform_caching = false

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Compress JavaScripts and CSS
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Log to STDOUT
  # config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  # Force SSL in production
  config.force_ssl = false

  # Configure SMTP
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_HOST'] || Rails.application.secrets[:smtp_host],
    port: 587,
    user_name: ENV['SMTP_USERNAME'] || Rails.application.secrets[:smtp_username],
    password: ENV['SMTP_PASSWORD'] || Rails.application.secrets[:smtp_password],
    authentication: :login,
    enable_starttls_auto: true
  }

  # Send e-mail on exceptions
  config.middleware.use ExceptionNotification::Rack,
                        email: {
                          email_prefix: '[Roles Management] ',
                          sender_address: ENV['SMTP_FROM_ADDRESS'] || Rails.application.secrets[:smtp_from_address],
                          exception_recipients: %w[dssit-devs-exceptions@ucdavis.edu]
                        }

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  Rack::Timeout::Logger.level = Logger::ERROR
end
