class WheneverMailer < ActionMailer::Base
  # CHANGEME
  default from: "no-reply@roles.dss.ucdavis.edu"
  
  def test_email(user)
    @user = user
    logger.info "Sending test e-mail to #{user.email}..."
    mail(:to => user.email, :subject => "A Test E-Mail from roles.dss.ucdavis.edu")
  end
  
  def adsync_report(email, log)
    @log = log
    logger.info "Sending AD Sync report e-mail to #{email}..."
    mail(:to => email, :subject => "DSS-RM: AD Sync Report for %s" % [Time.now.strftime("%A %B %d, %Y")])
  end
  
  def ldap_report(email, log)
    @log = log
    logger.info "Sending LDAP Report e-mail to #{email}..."
    mail(:to => email, :subject => "DSS-RM: LDAP Import Report for %s" % [Time.now.strftime("%A %B %d, %Y")])
  end
end
