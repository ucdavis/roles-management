class IntegrationMetadatum < ApplicationRecord
  validates :key, uniqueness: true

  def self.get(key)
    find_by_key(key)&.value
  end

  def self.put(key, value)
    record = find_or_create_by(key: key)
    record.value = value
    record.save!
  end

  def self.clear(key)
    record = get(key)
    record&.destroy
  end
end
