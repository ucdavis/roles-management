class WheneverMailer < ActionMailer::Base
  # CHANGEME
  default from: "no-reply@roles.dss.ucdavis.edu"
  
  def test_email(user)
    @user = user
    logger.info "Sending test e-mail to #{user.email}..."
    mail(:to => user.email, :subject => "A Test E-Mail from roles.dss.ucdavis.edu")
  end
  
  def adsync_report(log)
    @log = log
    # E-mail to each RM admin (anyone with 'admin' permission on this app)
    admin_role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
    Role.find_by_id(admin_role_id).people.each do |admin|
      logger.info "Sending AD Sync report e-mail to #{admin.email}..."
      mail(:to => admin.email, :subject => "DSS-RM: AD Sync Report for %s" % [Time.now.strftime("%A %B %d, %Y")])
    end
  end
  
  def ldap_report(log)
    @log = log
    # E-mail to each RM admin (anyone with 'admin' permission on this app)
    admin_role_id = Application.find_by_name("DSS Rights Management").roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
    Role.find_by_id(admin_role_id).people.each do |admin|
      logger.info "Sending LDAP Report e-mail to #{admin.email}..."
      mail(:to => admin.email, :subject => "DSS-RM: LDAP Import Report for %s" % [Time.now.strftime("%A %B %d, %Y")])
    end
  end
end
