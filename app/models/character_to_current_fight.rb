class CharacterToCurrentFight < ActiveRecord::Base
  belongs_to :character
   belongs_to :current_fight
end
