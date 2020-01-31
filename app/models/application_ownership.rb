class ApplicationOwnership < ApplicationRecord
  include Immutable

  belongs_to :application, touch: true
  belongs_to :entity, touch: true

  validates_presence_of :application, :entity
  validates_uniqueness_of :application_id, scope: [:entity_id, :parent_id]
end
