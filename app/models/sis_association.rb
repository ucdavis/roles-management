class SisAssociation < ApplicationRecord
  include Immutable

  belongs_to :entity
  belongs_to :major

  validates_presence_of :association_rank
  validates_presence_of :level_code
end
