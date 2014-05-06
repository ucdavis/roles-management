require 'rake'

namespace :exception do
  desc 'Generates an exception'
  task :generate => :environment do
    incorrect_method_call
  end
end
