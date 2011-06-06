class Ability < ActiveRecord::Base
  has_many :character_to_ability
  has_many :characters, :through => :character_to_ability
end
