class Selection < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
end
