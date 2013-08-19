require 'test_helper'
require 'rails/performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionDispatch::PerformanceTest
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_admin_access
    
    generate_entities(1000)
  end
  
  def test_api_entities_index
    get '/api/entities', :format => :json
  end
  
  # Generates a number of nonsense entities for performance testing
  def generate_entities(count)
    without_access_control do
      for i in 1..count
        e = Entity.new
        e.type = "Person"
        e.loginid = "entity#{i}"
        e.first = "First#{i}"
        e.last = "Last#{i}"
        e.save!
      end
    end
  end
end
