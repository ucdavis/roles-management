require 'rake'

namespace :temp_tasks do
  desc 'Throws an exception on purpose. Used for checking background exception handling.'
  task :throw_exception do
    doesntexist
  end
end
