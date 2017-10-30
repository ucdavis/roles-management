class SisAssociation < ApplicationRecord
  belongs_to :entity
  belongs_to :major

  after_save { GroupRule.resolve_target!(:major, entity.id) }
  after_destroy { GroupRule.resolve_target!(:major, entity.id) }
end
