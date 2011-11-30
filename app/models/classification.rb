class Classification < ActiveRecord::Base
  has_and_belongs_to_many :titles

  attr_reader :title_tokens
  
  def title_tokens=(ids)
      self.title_ids = ids.split(",")
  end
end
