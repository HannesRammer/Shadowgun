class CharacterToRace < ActiveRecord::Base
   belongs_to :character
  belongs_to :race
end
