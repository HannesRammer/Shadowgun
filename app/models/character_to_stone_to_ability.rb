class CharacterToStoneToAbility < ActiveRecord::Base
belongs_to :character
  belongs_to :stone
  belongs_to :ability
end
