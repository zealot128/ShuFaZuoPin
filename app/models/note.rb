class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  attr_protected :user_id
end
