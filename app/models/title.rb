class Title < ActiveRecord::Base
  has_and_belongs_to_many :classifications
  has_many :people

  validates :name, :presence => true
  validates :code, :presence => true, :uniqueness => true

  def as_json(options={})
      { :id => self.id, :name => self.name, :code => self.code }
  end
end
