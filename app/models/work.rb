class Work < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  
end
