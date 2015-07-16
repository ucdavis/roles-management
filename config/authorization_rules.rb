authorization do
  role :admin do
    # For creating/deleting applications
    has_permission_on :applications, :to => :manage
    has_permission_on :entities, :to => :manage
    has_permission_on :person_favorite_assignments, :to => :manage
    has_permission_on :application_ownerships, :to => :manage
    has_permission_on :roles, :to => :manage
    has_permission_on :groups, :to => :manage
    has_permission_on :ous, :to => :manage
    has_permission_on :group_rules, :to => :manage
    has_permission_on :people, :to => [:manage, :search]
    has_permission_on :application_operatorships, :to => :manage
    has_permission_on :role_assignments, :to => :manage
    has_permission_on :group_ownerships, :to => :manage
    has_permission_on :group_operatorships, :to => :manage
    has_permission_on :group_memberships, :to => :manage
    has_permission_on :affiliations, :to => :manage
    has_permission_on :majors, :to => :manage
    has_permission_on :titles, :to => :manage
    has_permission_on :activity_logs, :to => :manage
    has_permission_on :activity_log_tags, :to => :manage
    has_permission_on :activity_log_tag_associations, :to => :manage
    has_permission_on :admin_activity_logs, :to => :manage # controller version of model 'activity_logs'

    # For API keys
    has_permission_on :admin_api_key_users, :to => :manage
    has_permission_on :api_key_users, :to => :manage

    # For impersonating
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate] #, :ad_path_check]

    # For whitelisted IP users
    has_permission_on :admin_api_whitelisted_ip_users, :to => :manage
    has_permission_on :api_whitelisted_ip_users, :to => :manage

    # For viewing enqueued jobs
    has_permission_on :admin_queued_jobs, :to => :manage

    includes :api_reader
  end

  # API whitelisted users are not quite admins. Grant specific access here
  role :api_whitelist do
    has_permission_on :roles, :to => :read

    includes :api_reader
  end

  # API key users are not quite admins. Grant specific access here
  role :api_key do
    has_permission_on :roles, :to => :manage
    has_permission_on :role_assignments, :to => :manage
    has_permission_on :applications, :to => :manage
    has_permission_on :groups, :to => :manage
    has_permission_on :group_rules, :to => :manage
    has_permission_on :people, :to => :manage
    has_permission_on :entities, :to => :manage

    has_permission_on :api_v1_roles, :to => :manage

    includes :api_reader
  end

  role :operate do
    has_permission_on :applications, :to => :read

    has_permission_on :roles, :to => [:show, :read, :update] do
      if_attribute :application => { :name => is_not { 'DSS Roles Management' } }
    end

    has_permission_on :role_assignments, :to => [:create, :delete] do
      # Do not allow operators to make assignments against DSS RM card
      if_attribute :role => { :application => { :name => is_not { 'DSS Roles Management' } } }
    end

    has_permission_on :group_memberships, :to => :manage

    includes :access
  end

  role :access do
    # Allow access to the main page
    has_permission_on :applications, :to => :index

    # Allow creating Activity Log entries
    has_permission_on :activity_logs, :to => :create
    has_permission_on :activity_log_tags, :to => :create
    has_permission_on :activity_log_tag_associations, :to => :create

    # Allow reading of organizations
    has_permission_on :organizations, :to => :read

    # Needed for group rule typeahead lookups
    has_permission_on :ous, :to => :read
    has_permission_on :affiliations, :to => :read
    has_permission_on :majors, :to => :read
    has_permission_on :titles, :to => :read

    # Owners can read and update their own applications
    has_permission_on :applications, :to => [:read, :update] do
      if_attribute :owners => contains { user }
    end
    # Operators can read and update their assigned applications
    has_permission_on :applications, :to => [:read, :update] do
      if_attribute :operators => contains { user }
    end
    # NOTE: 'access' role cannot create or destroy applications

    # Allow creating/updating/reading of roles which belong to an application they own
    has_permission_on :roles, :to => [:read, :update, :create, :delete] do
      if_attribute :application => { :owners => contains { user } }
    end
    has_permission_on :application_ownerships, :to => [:read, :update, :create, :delete] do
      if_attribute :application => { :owners => contains { user } }
    end
    has_permission_on :application_operatorships, :to => [:read, :update, :create, :delete] do
      if_attribute :application => { :owners => contains { user } }
    end
    # Allow reading/updating/reading of roles which belong to an application they operator
    has_permission_on :roles, :to => [:show, :read, :update] do
      if_attribute :application => { :operators => contains { user } }
    end

    # Owning/operating applications requires reading :entities
    # Create/delete role_assignments for applications they own
    has_permission_on :role_assignments, :to => [:create, :delete] do
      if_attribute :role => { :application => { :owners => contains { user } } }
    end
    # Create/delete role_assignments for applications they operate
    has_permission_on :role_assignments, :to => [:create, :delete] do
      if_attribute :role => { :application => { :operators => contains { user } } }
    end

    # Allow viewing/searching of individuals
    has_permission_on :entities, :to => [:index, :show, :read]

    has_permission_on :people, :to => :read
    # You can only update your own details
    has_permission_on :people, :to => :update do
      if_attribute :id => is { user.id }
    end
    # We need this duplicated permission due to entities/people being polymorphic
    has_permission_on :entities, :to => :update do
      if_attribute :id => is { user.id }
    end

    # Allow managing of their own favorites
    has_permission_on :person_favorite_assignments, :to => [:create, :delete] do
      if_attribute :owner_id => is { user.id }
    end

    # # Allow creating groups
    has_permission_on :entities, :to => :create do
      if_attribute :type => is { 'Group' }
    end
    has_permission_on :groups, :to => :create
    # Allow deleting groups they own
    has_permission_on :entities, :to => :manage do
      if_attribute :owners => contains { user }
    end
    # Allow updating groups they operate
    has_permission_on :entities, :to => :update do
      if_attribute :operators => contains { user }
    end
    # Enabling this next rule triggers a bug where non-admin group owners
    # cannot add members to a group.
    # It doesn't seem to affect an operator simply adding a person to
    # a group but not having this does prevent an operator from updating
    # basic group attributes like name.
    has_permission_on :groups, :to => [:read, :update] do
      if_attribute :operators => contains { user }
    end
    has_permission_on :groups, :to => :manage do
      if_attribute :owners => contains { user }
    end

    has_permission_on :group_ownerships, :to => :manage do
      if_attribute :group => { :owners => contains { user } }
    end

    has_permission_on :group_operatorships, :to => :manage do
      if_attribute :group => { :owners => contains { user } }
    end
    has_permission_on :group_operatorships, :to => :manage do
      if_attribute :group => { :operators => contains { user } }
    end

    has_permission_on :group_memberships, :to => :manage do
      if_attribute :group => { :owners => contains { user } }
    end
    has_permission_on :group_memberships, :to => :manage do
      if_attribute :group => { :operators => contains { user } }
    end
    # Allow manging rules on groups they own
    has_permission_on :group_rules, :to => :manage do
      if_attribute :group => { :owners => contains { user } }
    end

    # Allow reading of any group
    has_permission_on :groups, :to => [:read, :show]

    # Allow searching/importing of people
    has_permission_on :people, :to => [:search, :import]
  end

  role :api_reader do
    has_permission_on :api_v1_people, :to => :read
    has_permission_on :api_v1_entities, :to => :read
    has_permission_on :api_v1_applications, :to => :read
    has_permission_on :api_v1_roles, :to => :read
    has_permission_on :api_v1_base, :to => [:validate]
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
