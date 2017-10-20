class Title < ApplicationRecord
  has_and_belongs_to_many :classifications
  has_many :people

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :unit, presence: true, uniqueness: false

  def as_json(_)
    { id: id, name: name, code: code, unit: unit }
  end
end
