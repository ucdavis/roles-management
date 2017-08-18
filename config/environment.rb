# Load the Rails application.
require_relative 'application'

require 'delayed_rake'

# Initialize the Rails application.
Rails.application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => $DSS_RM_CONFIG["cas"]["base_url"]
)
