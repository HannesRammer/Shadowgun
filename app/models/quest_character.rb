class QuestCharacter < ActiveRecord::Base
  belongs_to :quest
  belongs_to :character
end
