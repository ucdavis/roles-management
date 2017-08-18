DSSRM::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
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

  # Use a syslog-based logger for distributed log collection
  # config.logger = Syslogger.new("roles-management", Syslog::LOG_PID, Syslog::LOG_LOCAL0)
  # config.logger.level = Logger::INFO

  config.cache_store = :dalli_store #:mem_cache_store, "localhost"

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_files = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Compress JavaScripts and CSS
  config.assets.js_compressor = :uglifier

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Force SSL in production
  config.force_ssl = true

  # Use local sendmail
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Send e-mail on exceptions
  config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[Roles Management] ",
      :sender_address => %{no-reply@roles.dss.ucdavis.edu},
      :exception_recipients => %w{dssit-devs-exceptions@ucdavis.edu}
    }

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
