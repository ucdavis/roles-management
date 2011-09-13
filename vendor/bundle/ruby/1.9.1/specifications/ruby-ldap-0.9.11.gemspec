# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-ldap}
  s.version = "0.9.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Alexey Chebotar}]
  s.date = %q{2010-03-14}
  s.description = %q{It provides the interface to some LDAP libraries (e.g. OpenLDAP, Netscape SDK and Active Directory). The common API for application development is described in RFC1823 and is supported by Ruby/LDAP.
}
  s.email = %q{alexey.chebotar@gmail.com}
  s.extensions = [%q{extconf.rb}]
  s.files = [%q{extconf.rb}]
  s.homepage = %q{http://ruby-ldap.sourceforge.net/}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{ruby-ldap}
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Ruby/LDAP is an extension module for Ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
