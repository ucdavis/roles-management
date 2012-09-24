class ApiKey < ActiveRecord::Base
  using_access_control

  before_save :ensure_secret_exists

  has_many :applications

  def ensure_secret_exists
    if secret.nil?
      self.secret = generate_secret
    end
  end

  def generate_secret
    Digest::MD5.hexdigest('dssrm' + Time.now.to_i.to_s)
  end
end
