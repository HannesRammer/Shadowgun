class CultureToAbility < ActiveRecord::Base
  belongs_to :culture
  belongs_to :ability
end
