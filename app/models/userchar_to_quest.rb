class UsercharToQuest < ActiveRecord::Base
 belongs_to :character
  belongs_to :quest
end
