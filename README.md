# DSS Roles Management

Roles Management (RM) is a web-based management interface for people, roles, and applications, developed by the UC Davis Division of Social Science.

![Main screen with role selected](http://169.237.101.195/image1.png "Main screen with role selected")

RM is designed to allow anyone with employees or  virtual appliances (file servers, mailing lists, web applications) to manage and assign people and groups whatever permissions they wish without requiring the help of IT.

## Requirements

RM was written for Ruby 2.1 and Rails 4.2 and has been tested with Unicorn, PostgreSQL, and Linux. It should work fine with the Passenger web application server as well.

MySQL 5.6.4 is required to support timestamp granularity greater than one second (used in caching).

## Installation / Deployment

### Step 1. (Set configuration values)

RM is designed to be re-deployable in any workgroup, though there
are a few matters of configuration that need to be attended to:

config/database.example.yml
	Move this file to config/database.yml and set the appropriate values.

config/active_directory.example.yml
  Move this file to config/active_directory.yml and set the appropriate values.

config/secrets.example.yml
	Move this file to config/secrets.yml and set the value. It is recommended
	you use 'rake secret' to obtain a high quality secret.

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

### Step 2. (Standard Rails procedures)

Run the follow commands in order and ensure they complete successfully:

 * bundle install
 * bundle exec rake db:schema:load

### Step 3. (Add a user)

The follow steps obtain a user from a configured LDAP server and grant admin
access:

 * bundle exec rake user:grant_admin[the_username]

### Step 4. (Done!)

Run the application:

 * bundle exec rails server (visit localhost:3000 to view)

## Screenshots
![Group rule editor](http://169.237.101.195/image2.png "Group rule editor")
![Person dialog relations tab](http://169.237.101.195/image3.png "Person dialog relations tab")

## Owners and Operators
RM has two classes of users with administrative behavior: owners and operators. Their
application applies to both groups and applications:

  - Application/Group Owners: Can create, edit, and delete all attributes of an application or group.
  - Application Operators: Can make role assignments with that group or application but cannot edit
               any attributes.
  - Group Operators: Similar to Application Operators but with the added ability to add or remove explicit
               membersbut cannot edit the group rules.

## Authors
Christopher Thielen (cmthielen@ucdavis.edu)
