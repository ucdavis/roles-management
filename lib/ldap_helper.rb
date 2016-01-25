class LdapHelper
  require 'net-ldap'

  # Connects to the LDAP server. Settings are stored in Rails.root/config/ldap.yml
  def connect(log = nil)
    begin
      ldap_settings = YAML.load_file("#{Rails.root.to_s}/config/ldap.yml")['ldap']
    rescue Errno::ENOENT => e
      STDERR.puts "You need to configure #{Rails.root.join('config', 'ldap.yml')}."
      return false
    end
    
    server = {
      :host => 'ldap.ucdavis.edu',
      :base => 'ou=People,dc=ucdavis,dc=edu',
      :port => 636,
      :encryption => { :method => :simple_tls },
      :auth => {
        :method => :simple,
        :username => ldap_settings['base_dn'],
        :password => ldap_settings['base_pw']
      }
    }

    @conn = Net::LDAP.new(server)

    begin
      @conn.bind
    rescue Net::LDAP::Error => e
      log.error "LdapHelper could not connect to LDAP. Exception: #{e}" if log
      return false
    end

    return true
  end

  # Requires a block be passed:
  #   search("ldap_query").do |p| ... end
  # Returns false on no results or error, else return is undefined.
  def search(term, log = nil)
    log.debug "LdapHelper searching for '#{term}'" if log

    begin
      results = @conn.search(:filter => Net::LDAP::Filter.construct(term))
    rescue Net::LDAP::Error => e
      log.error "LdapHelper hit an error while querying LDAP with term '#{term}'. Exception: #{e}" if log
      return false
    end

    return results
  end

  def build_filters(log = nil)
    # Build needed LDAP filters
    # Staff filter
    staffFilter = '(&(ucdPersonAffiliation=staff*)(|'
    for d in UcdLookups::DEPT_CODES.keys()
      staffFilter = staffFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    staffFilter = staffFilter + '))'

    log.debug "Query: " + staffFilter if log

    # Faculty filter
    facultyFilter = '(&(ucdPersonAffiliation=faculty*)(|'
    for d in UcdLookups::DEPT_CODES.keys()
        facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    facultyFilter = facultyFilter + '))'

    log.debug "Query: " + facultyFilter if log

    # Student filter
    studentFilter = '(&(ucdPersonAffiliation=student:graduate)(|'
    for m in UcdLookups::MAJORS.keys()
         studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
    end
    studentFilter = studentFilter + '))'

    log.debug "Query: " + studentFilter if log

    [staffFilter,facultyFilter,studentFilter]
  end
end
