class ConceptToAbility < ActiveRecord::Base
  belongs_to :concept
  belongs_to :ability
end
