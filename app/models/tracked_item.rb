class TrackedItem < ApplicationRecord
  validates_presence_of :kind, :item_id
  validates_uniqueness_of :item_id, scope: :kind
  validates_inclusion_of :kind, in: ['department', 'gr_major']
end
