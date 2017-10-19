class LdapHelper
  require 'net-ldap'

  # Connects to the LDAP server. Settings are stored in Rails.root/config/ldap.yml
  def connect(log = nil)
    begin
      ldap_settings = YAML.load_file("#{Rails.root}/config/ldap.yml")['ldap']
    rescue Errno::ENOENT
      STDERR.puts "You need to configure #{Rails.root.join('config', 'ldap.yml')}."
      return false
    end

    server = {
      host: ldap_settings['host'],
      base: ldap_settings['search_dn'],
      port: ldap_settings['port'],
      encryption: { method: :simple_tls },
      auth: {
        method: :simple,
        username: ldap_settings['base_dn'],
        password: ldap_settings['base_pw']
      }
    }

    @conn = Net::LDAP.new(server)

    begin
      @conn.bind
    rescue Net::LDAP::Error => e
      log&.error "LdapHelper could not connect to LDAP. Exception: #{e}"
      return false
    end

    return true # rubocop:disable Style/RedundantReturn
  end

  # Requires a block be passed:
  #   search("ldap_query").do |p| ... end
  # Returns false on no results or error, else return is undefined.
  def search(term, log = nil)
    log&.debug "LdapHelper searching for '#{term}'"

    begin
      results = @conn.search(filter: Net::LDAP::Filter.construct(term))
    rescue Net::LDAP::Error => e
      log&.error "LdapHelper hit an error while querying LDAP with term '#{term}'. Exception: #{e}"
      return false
    end

    return results # rubocop:disable Style/RedundantReturn
  end

  def build_filters(log = nil)
    # Build needed LDAP filters
    # Staff filter
    staff_filter = '(&(ucdPersonAffiliation=staff*)(|'
    UcdLookups::DEPT_CODES.keys.each do |d|
      staff_filter += '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    staff_filter += '))'

    log&.debug "Query: #{staff_filter}"

    # Faculty filter
    faculty_filter = '(&(ucdPersonAffiliation=faculty*)(|'
    UcdLookups::DEPT_CODES.keys.each do |d|
      faculty_filter += '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    faculty_filter += '))'

    log&.debug "Query: #{faculty_filter}"

    # Student filter
    student_filter = '(&(ucdPersonAffiliation=student:graduate)(|'
    UcdLookups::MAJORS.keys.each do |m|
      student_filter += '(ucdStudentMajor=' + m + ')'
    end
    student_filter += '))'

    log&.debug "Query: #{student_filter}"

    [staff_filter, faculty_filter, student_filter]
  end
end
