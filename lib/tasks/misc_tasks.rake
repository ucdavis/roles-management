require 'rake'

namespace :misc do
  desc 'Updates config/initializers/last_updated.rb with the current date/time.'
  task :update_last_updated do
    File.open("#{Rails.root}/config/initializers/last_updated.rb", 'w') {|f| f.write("LAST_UPDATED = '#{Time.now}'") }
  end
end
