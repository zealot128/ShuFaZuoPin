class Selection < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  attr_accessor :search
  attr_accessible :character_id

end
