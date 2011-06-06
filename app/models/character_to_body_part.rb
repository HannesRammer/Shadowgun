class CharacterToBodyPart < ActiveRecord::Base
  belongs_to :character
  belongs_to :body_part
end
