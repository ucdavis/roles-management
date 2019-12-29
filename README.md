# DSS Roles Management

Roles Management (RM) is a web-based management interface for people, roles, and applications, developed by the UC Davis Division of Social Science.

![Main screen with role selected](http://169.237.101.195/image1.png "Main screen with role selected")

RM is designed to allow anyone with employees or  virtual appliances (file servers, mailing lists, web applications) to manage and assign people and groups whatever permissions they wish without requiring the help of IT.

## Requirements

RM was written for Ruby 2.1 and Rails 4.2 and has been tested with Unicorn, PostgreSQL, and Linux. It should work fine with the Passenger web application server as well.

## Installation

### Step 1. Set up secrets file

 * Copy docker-web-secrets.env.sample to docker-web-secrets.env and fill in values.

### Step 2. Run the services

 * docker-compose up

### Step 3. Set up the database

 * docker exec <container-id> rails db:setup
 * docker exec <container-id> rails activitylog:create_table

### Step 4. Add the first user
 * docker exec <container-id> rails title:import_titles_with_ucpath_csv[file.csv]
 * docker exec <container-id> rails dw:import_pps_departments
 * docker exec <container-id> rails dw:import[username]
 * docker exec <container-id> rails user:grant_admin[username]

### Step 5. Visit the service

Open your browser to localhost:3000

## Running Tests

Roles Management has two forms of tests: Rails-based unit tests and Cypress
end-to-end tests.

### Running Rails tests

1. `rails test`

### Running Cypress tests

1. Ensure Cypress is installed: `npm install`
2. Ensure Roles management is running with CAS override: `_RM_DEV_LOGINID=dssapps rails s`
3. Ensure CAS override user is in RM database
4. Run Cypress: `npx cypress open`

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

## Misc. Setup
### Import titles from CSV in Docker container
 1. docker cp titles.csv <container-id>:/usr/src/app
 2. docker exec <container-id> rails title:replace_titles_with_csv[titles.csv]

### Import departments
 * docker exec <container-id> rails dw:import_pps_departments

## Authors
Christopher Thielen (cmthielen@ucdavis.edu)
