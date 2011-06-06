class CharacterToWeapon < ActiveRecord::Base
  belongs_to :character
  belongs_to :weapon
end
