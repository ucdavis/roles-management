DSSRM::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Use a different logger for distributed setups
  # FIXME - require 'syslog_logger' no longer works with gem version >= 2.0?
  #require 'syslog_logger'
  #config.logger = SyslogLogger.new("roles-management")

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

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

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.3

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Don't forget additional files requiring compilation
  config.assets.precompile += ['cards.js', 'controllers/applications.js', 'controllers/templates.js', 'site.css']

  # Generate digests for assets URLs
  config.assets.digest = true
  
  # Use strong CSS compression via YUI
  config.assets.css_compressor = :yui

  # Force SSL in production
  config.force_ssl = true

  # Use local sendmail
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  # Send e-mail on exceptions
  config.middleware.use ExceptionNotifier,
    sender_address: 'no-reply@roles.dss.ucdavis.edu',
    exception_recipients: 'cmthielen@ucdavis.edu',
    ignore_exceptions: ExceptionNotifier.default_ignore_exceptions # + [RuntimeError]
end
