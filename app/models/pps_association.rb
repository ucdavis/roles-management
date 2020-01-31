class PpsAssociation < ApplicationRecord
  include Immutable

  belongs_to :person
  belongs_to :title
  belongs_to :department
  belongs_to :admin_department, class_name: 'Department'
  belongs_to :appt_department, class_name: 'Department'

  validates_presence_of :association_rank
  validates_presence_of :position_type_code

  def position_type_label
    case position_type_code
    when 1
      'Contract'
    when 2
      'Regular/Career'
    when 3
      'Limited, Formerly Casual'
    when 4
      'Casual/RESTRICTED-Students'
    when 5
      'Academic'
    when 6
      'Per Diem'
    when 7
      'Regular/Career Partial YEAR'
    when 8
      'Floater'
    else
      'Unknown'
    end
  end

  def employee_class_label
    require 'ucd_ucpath_employee_classes'
    UcdUcPathEmployeeClasses::EMPLOYEE_CLASS_LABELS[employee_class.to_s]
  end
end
