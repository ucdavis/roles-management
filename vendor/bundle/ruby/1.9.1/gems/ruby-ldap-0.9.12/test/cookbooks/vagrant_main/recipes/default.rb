# vagrant_main cookbook
# This cookbook includes and sets up a server with openldap.
#
require_recipe 'apt'
require_recipe 'openldap::server'

execute[apt-get-update]

# require_recipe 'nginx'
# include_recipe "openldap::server"
# require_recipe 'postgresql'
# require_recipe 'sqlite'
