class SubCulture < ActiveRecord::Base

  has_many :culture_to_sub_culture
  has_many :cultures, :through => :culture_to_sub_culture

end


