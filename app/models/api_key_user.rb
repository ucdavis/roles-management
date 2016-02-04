class ApiKeyUser < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  validates :name, :uniqueness => true, :presence => true
  validates :secret, :uniqueness => true, :presence => true

  before_validation :ensure_secret_exists
  has_many :applications

  def log_identifier
    "API Key(#{name})"
  end

  def role_symbols
    [:api_key]
  end

  def ensure_secret_exists
    if secret.nil?
      self.secret = generate_secret
    end
  end

  def generate_secret
    Digest::MD5.hexdigest('dssrm' + Time.now.to_i.to_s)
  end
end
