class LdapHelper
  require 'ldap'

  LDAP_SETTINGS = YAML.load_file("#{Rails.root.to_s}/config/ldap.yml")['ldap']

  # Connects to the LDAP server. Settings are stored in Rails.root/config/ldap.yml (LDAP_SETTINGS)
  def connect
    # Connect to LDAP
    @conn = LDAP::SSLConn.new( 'ldap.ucdavis.edu', 636 )
    @conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
    @conn.bind(dn = LDAP_SETTINGS['base_dn'], password = LDAP_SETTINGS['base_pw'] )
  end

  def disconnect
    @conn.unbind
  end

  # Requires a block be passed:
  #   search("ldap_query").do |p| ... end
  # Returns false on no results or error, else return is undefined.
  def search(term)
    Rails.logger.debug "LdapHelper searching for '#{term}'"
    begin
      @conn.search(LDAP_SETTINGS['search_dn'], LDAP::LDAP_SCOPE_SUBTREE, term) do |result|
        yield result
      end
    rescue RuntimeError => e
      Rails.logger.warning "LdapHelper search resulted in exception. Term: '#{term}'. Exception: #{e}"
      return false
    end
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

    # Manual filter
    # manualFilter = []
    # for m in UcdLookups::MANUAL_INCLUDES
    #   manualFilter << '(uid=' + m + ')'
    # end
    #
    # log.debug "Query: " + manualFilter.join(",")

    [staffFilter,facultyFilter,studentFilter] #+ manualFilter
  end
end
