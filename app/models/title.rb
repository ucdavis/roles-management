class Title < ActiveRecord::Base
  has_and_belongs_to_many :classifications

  def as_json(options={}) 
      { :id => self.id, :name => self.name } 
  end
end
