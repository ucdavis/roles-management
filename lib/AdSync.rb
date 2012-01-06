module AdSync
  require 'active_directory'
  AD_PEOPLE_SETTINGS = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ad_people']
  AD_GROUPS_SETTINGS = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ad_groups']
  
  def AdSync.fetch_user(loginid)
    settings = {
        :host => AD_PEOPLE_SETTINGS['host'],
        :base => AD_PEOPLE_SETTINGS['base'],
        :port => 636,
        :encryption => :simple_tls,
        :auth => {
          :method => :simple,
          :username => AD_PEOPLE_SETTINGS['user'],
          :password => AD_PEOPLE_SETTINGS['pass']
        }
    }

    ActiveDirectory::Base.setup(settings)
    ActiveDirectory::User.find(:first, :samaccountname => loginid)
  end
  
  def AdSync.add_to_group(user, group)
    settings = {
        :host => AD_GROUPS_SETTINGS['host'],
        :base => AD_GROUPS_SETTINGS['base'],
        :port => 636,
        :encryption => :simple_tls,
        :auth => {
          :method => :simple,
          :username => AD_GROUPS_SETTINGS['user'],
          :password => AD_GROUPS_SETTINGS['pass']
        }
    }

    ActiveDirectory::Base.setup(settings)
    g = ActiveDirectory::Group.find(:first, :cn => group)

    g.add user
  end
end
