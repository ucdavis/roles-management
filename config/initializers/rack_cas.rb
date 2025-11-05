require 'rack/cas'

Rails.application.config.middleware.use(
  Rack::CAS,
  server_url: ENV['CAS_URL'] || Rails.application.secrets[:cas_url]
)
