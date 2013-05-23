require 'rake'

namespace :jasmine do
  desc 'Runs Jasmine test suite using PhantomJS'
  task :run do
    exec 'phantomjs script/run-jasmine.js http://dss-rm.dev/jasmine'
  end
end

