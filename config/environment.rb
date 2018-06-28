# Load the Rails application.
require_relative 'application'

require 'delayed_rake'

# Initialize the Rails application.
Rails.application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  cas_base_url: ENV['CAS_URL'] || Rails.application.secrets[:cas_url]
)
