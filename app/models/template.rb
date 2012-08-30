class Template < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :rules, :class_name => "TemplateRule", :dependent => :destroy
  has_many :assignments, :class_name => "TemplateAssignment", :dependent => :destroy

  # Returns a list of the UIDs of each assignment
  def assignment_uids
    uids = []

    assignments.each do |assignment|
      uids << assignment.resolve
    end

    uids
  end
end
