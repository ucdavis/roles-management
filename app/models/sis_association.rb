class SisAssociation < ApplicationRecord
  belongs_to :entity
  belongs_to :major

  validates_presence_of :association_rank
  validates_presence_of :level_code

  after_save { GroupRule.resolve_target!(:major, entity.id) }
  after_destroy { GroupRule.resolve_target!(:major, entity.id) }
end
