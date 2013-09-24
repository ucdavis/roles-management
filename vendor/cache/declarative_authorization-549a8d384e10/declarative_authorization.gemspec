# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "declarative_authorization"
  s.version = "0.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steffen Bartsch"]
  s.date = "2013-09-24"
  s.email = "sbartsch@tzi.org"
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG"]
  s.files = ["CHANGELOG", "MIT-LICENSE", "README.rdoc", "Rakefile", "authorization_rules.dist.rb", "garlic_example.rb", "init.rb", "app/controllers/authorization_rules_controller.rb", "app/controllers/authorization_usages_controller.rb", "app/helpers/authorization_rules_helper.rb", "app/views/authorization_rules/_change.erb", "app/views/authorization_rules/_show_graph.erb", "app/views/authorization_rules/_suggestions.erb", "app/views/authorization_rules/change.html.erb", "app/views/authorization_rules/graph.dot.erb", "app/views/authorization_rules/graph.html.erb", "app/views/authorization_rules/index.html.erb", "app/views/authorization_usages/index.html.erb", "config/routes.rb", "lib/declarative_authorization.rb", "lib/declarative_authorization/authorization.rb", "lib/declarative_authorization/development_support/analyzer.rb", "lib/declarative_authorization/development_support/change_analyzer.rb", "lib/declarative_authorization/development_support/change_supporter.rb", "lib/declarative_authorization/development_support/development_support.rb", "lib/declarative_authorization/helper.rb", "lib/declarative_authorization/in_controller.rb", "lib/declarative_authorization/in_model.rb", "lib/declarative_authorization/maintenance.rb", "lib/declarative_authorization/obligation_scope.rb", "lib/declarative_authorization/rails_legacy.rb", "lib/declarative_authorization/railsengine.rb", "lib/declarative_authorization/reader.rb", "lib/tasks/authorization_tasks.rake", "test/authorization_test.rb", "test/controller_filter_resource_access_test.rb", "test/controller_test.rb", "test/database.yml", "test/development_support", "test/dsl_reader_test.rb", "test/helper_test.rb", "test/maintenance_test.rb", "test/model_test.rb", "test/schema.sql", "test/test_helper.rb"]
  s.homepage = "http://github.com/stffn/declarative_authorization"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = "2.0.3"
  s.summary = "declarative_authorization is a Rails plugin for maintainable authorization based on readable authorization rules."
end
