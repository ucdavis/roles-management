# Load the rails application
require File.expand_path('../application', __FILE__)

require 'delayed_rake'

# Initialize the rails application
DSSRM::Application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => $DSS_RM_CONFIG["cas"]["base_url"]
)
