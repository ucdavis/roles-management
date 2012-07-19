class ApiKey < ActiveRecord::Base
  before_save :ensure_secret_exists

  # attr_accessible :title, :body
  has_many :applications

  def ensure_secret_exists
    if secret.nil?
      self.secret = generate_secret
    end
  end

  def generate_secret
    Digest::MD5.hexdigest(self.name + Time.now.to_i.to_s)
  end
end
