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
  def search(term)
    @conn.search(LDAP_SETTINGS['search_dn'], LDAP::LDAP_SCOPE_SUBTREE, term) do |result|
      yield result
    end
  end
end
