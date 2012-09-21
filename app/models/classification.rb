class Classification < ActiveRecord::Base
  using_access_control

  has_and_belongs_to_many :titles

  validates :name, :presence => true, :uniqueness => true

  attr_reader :title_tokens

  def title_tokens=(ids)
      self.title_ids = ids.split(",")
  end
end
