class CharacterToAbility < ActiveRecord::Base
  belongs_to :character
  belongs_to :ability

end
