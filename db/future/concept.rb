class Concept < ActiveRecord::Base
  has_many :concept_to_ability
  has_many :abilities, :through => :concept_to_ability

end
