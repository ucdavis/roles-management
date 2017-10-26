class Title < ApplicationRecord
  has_many :people

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :unit, presence: true, uniqueness: false

  # Title code must have leading zeroes to ensure a length of four
  before_save { |title| title.code = title.code.rjust(4, '0') }

  def as_json(_)
    { id: id, name: name, code: code, unit: unit }
  end
end
