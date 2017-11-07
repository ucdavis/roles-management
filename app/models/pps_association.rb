class PpsAssociation < ApplicationRecord
  belongs_to :person
  belongs_to :title
  belongs_to :department

  validates_presence_of :association_rank
  validates_presence_of :position_type_code

  after_save do
    GroupRule.resolve_target!(:pps_unit, person_id)
    GroupRule.resolve_target!(:pps_position_type, person_id)
  end
  after_destroy do
    GroupRule.resolve_target!(:pps_unit, person_id)
    GroupRule.resolve_target!(:pps_position_type, person_id)
  end

  # '1', 'Contract'
  # '2', 'Regular/Career'
  # '3', 'Limited, Formerly Casual'
  # '4', 'Casual/RESTRICTED-Students'
  # '5', 'Academic'
  # '6', 'Per Diem'
  # '7', 'Regular/Career Partial YEAR'
  # '8', 'Floater'
end
