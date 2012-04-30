# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-ldap"
  s.version = "0.9.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexey Chebotar"]
  s.date = "2011-12-27"
  s.description = "It provides the interface to some LDAP libraries (e.g. OpenLDAP, Netscape SDK and Active Directory). The common API for application development is described in RFC1823 and is supported by Ruby/LDAP.\n"
  s.email = "alexey.chebotar@gmail.com"
  s.extensions = ["extconf.rb"]
  s.files = ["extconf.rb"]
  s.homepage = "http://ruby-ldap.sourceforge.net/"
  s.require_paths = ["lib"]
  s.rubyforge_project = "ruby-ldap"
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby/LDAP is an extension module for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
