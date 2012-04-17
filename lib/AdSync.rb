module AdSync
  require 'active_directory'
  AD_PEOPLE_SETTINGS = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ad_people']
  AD_GROUPS_SETTINGS = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ad_groups']
  
  # Takes loginid as a string (e.g. 'jsmith') and returns an ActiveDirectory::User object
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

  # Takes name as a string (e.g. 'this-that') and returns an ActiveDirectory::Group object
  def AdSync.fetch_group(group_name)
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
    ActiveDirectory::Group.find(:first, :cn => group_name)
  end
  
  # Takes user as an ActiveDirectory::User object and group as a ActiveDirectory::Group object and returns boolean
  def AdSync.add_user_to_group(user, group)
    if group.nil?
      return false
    end
    
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

    group.add user
  end
  
  # Takes group as an ActiveDirectory::Group object and returns an array of users
  def AdSync.list_group_members(group)
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
    
    group.member_users
  end
  
  # Returns true if 'user' is in 'group' (both objects should be queried using fetch_user and fetch_group)
  def AdSync.in_group(user, group)
    unless user.nil? or group.nil?
      if user.member_of? group
        return true
      end
    end
    
    return false
  end
end
