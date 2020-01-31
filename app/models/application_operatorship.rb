class ApplicationOperatorship < ApplicationRecord
  include Immutable

  validates_presence_of :application, :entity
  validates_uniqueness_of :application_id, scope: [:entity_id, :parent_id]

  belongs_to :application, touch: true
  belongs_to :entity, touch: true
end
