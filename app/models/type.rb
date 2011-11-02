class Type < ActiveRecord::Base
  has_many :works
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :maximum => 30
  
end