class WheneverMailer < ActionMailer::Base
  # CHANGEME
  default from: "no-reply@roles.dss.ucdavis.edu"
  
  def test_email(user)
    @user = user
    mail(:to => user.email, :subject => "A Test E-Mail from roles.dss.ucdavis.edu")
  end
end
