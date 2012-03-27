# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "active_directory"
  s.version = "1.5.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam T Kerr"]
  s.date = "2011-04-27"
  s.description = "ActiveDirectory uses Net::LDAP to provide a means of accessing and modifying an Active Directory data store.  This is a fork of the activedirectory gem."
  s.email = "ajrkerr@gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/ajrkerr/active_directory"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "An interface library for accessing Microsoft's Active Directory."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ldap>, [">= 0.1.1"])
    else
      s.add_dependency(%q<net-ldap>, [">= 0.1.1"])
    end
  else
    s.add_dependency(%q<net-ldap>, [">= 0.1.1"])
  end
end
