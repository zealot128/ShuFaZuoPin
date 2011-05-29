class Character < ActiveRecord::Base
  has_many :users, :through => :selection
  has_many :selections
end
