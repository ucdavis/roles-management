# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jasminerice"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brad Phelan"]
  s.date = "2013-10-04"
  s.description = "Full support for the Rails 3.1 asset pipeline when bdd'ing your coffeescript or javascript using jasmine"
  s.files = ["app/assets", "app/assets/javascripts", "app/assets/javascripts/jasminerice.js.coffee", "app/controllers", "app/controllers/jasminerice", "app/controllers/jasminerice/application_controller.rb", "app/controllers/jasminerice/spec_controller.rb", "app/helpers", "app/helpers/jasminerice", "app/helpers/jasminerice/application_helper.rb", "app/views", "app/views/jasminerice", "app/views/jasminerice/spec", "app/views/jasminerice/spec/index.html.erb", "config/routes.rb", "lib/generators", "lib/generators/jasminerice", "lib/generators/jasminerice/install_generator.rb", "lib/generators/jasminerice/templates", "lib/generators/jasminerice/templates/example_fixture.html.haml", "lib/generators/jasminerice/templates/example_spec.js.coffee", "lib/generators/jasminerice/templates/jasminerice.rb", "lib/generators/jasminerice/templates/spec.css", "lib/generators/jasminerice/templates/spec.js.coffee", "lib/jasminerice.rb", "vendor/assets", "vendor/assets/javascripts", "vendor/assets/javascripts/jasmine-html.js", "vendor/assets/javascripts/jasmine-jquery-1.5.8.js", "vendor/assets/javascripts/jasmine.js", "vendor/assets/stylesheets", "vendor/assets/stylesheets/jasmine.css", "MIT.LICENSE", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Pain free coffeescript unit testing for Rails 3.1 using jasmine"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<coffee-rails>, [">= 0"])
    else
      s.add_dependency(%q<coffee-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<coffee-rails>, [">= 0"])
  end
end
