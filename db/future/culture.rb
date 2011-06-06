class Culture < ActiveRecord::Base
  has_many :culture_to_ability
  has_many :abilities, :through => :culture_to_ability
  has_many :culture_to_sub_culture
  has_many :sub_cultures, :through => :culture_to_sub_culture
end
