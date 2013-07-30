# DSS Roles Management

Roles Management (RM) is a people, roles, and application management web
application developed by the UC Davis Division of Social Science.

![Main screen with role selected](http://169.237.101.195/image1.png "Main screen with role selected")

The purpose of DSS RM is to allow anyone with subordinate employees and
virtual appliances (file servers, mailing lists, web applications) to
manage and assign their people and groups whatever permissions they wish
without requiring the help of IT.

## Requirements

RM was written for Ruby 1.9 and Rails 3.2 and is deployed using Unicorn and
PostgreSQL. It has been tested on Apache and Nginix and should run fine on
Linux, Mac OS X, and Windows. It has not been tested with Microsoft's
IronRuby, and as of this writing, IronRuby does not support Ruby 1.9, which
is a requirement for this application.

## Deployment

RM is designed to be re-deployable in any organization, though there are a few
matters of configuration that need to be attended to:

config/database.yml.example
	Move this file to config/database.yml and set the appropriate values.

config/api_keys.yml.example
	Move this file to config/api_keys.yml and set the appropriate values.

config/ldap.yml.example
  Move this file to config/ldap.yml and set the appropriate values.

config/active_directory.yml.example
  Move this file to config/active_directory.yml and set the appropriate values.

config/environment.rb
	Recode the cas.ucdavis.edu URL to your CAS server, or remove CAS entirely. If
  you decide to remove CAS, also remove the before_filter in
	app/controllers/application_controller.rb.

config/deploy.rb
	You'll likely want to set this to your own Capistrano setup or delete it
	if you do not use Capistrano.

config/schedule.rb
  This file controls when cron jobs run to sync databases. It is currently
  set up to do so at night, but you should change the time in this file if
  you'd like anything else.

You can also search the code for "INSTALLME" (case-sensitive) or "CHANGEME"
in case this README neglects any configuration details.

## Screenshots
![Group rule editor](http://169.237.101.195/image2.png "Group rule editor")
![Person dialog relations tab](http://169.237.101.195/image3.png "Person dialog relations tab")

## Authors
Christopher Thielen (cmthielen@ucdavis.edu)
