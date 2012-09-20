class Title < ActiveRecord::Base
  has_and_belongs_to_many :classifications

  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

  def as_json(options={})
      { :id => self.id, :name => self.name, :code => self.code }
  end
end
