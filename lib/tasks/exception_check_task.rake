require 'rake'

namespace :exception do
  desc 'Generates an exception'
  task :generate => :environment do
    begin
      incorrect_method_call
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end
end
