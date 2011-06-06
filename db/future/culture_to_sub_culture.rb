class CultureToSubCulture < ActiveRecord::Base
  belongs_to :culture
  belongs_to :sub_culture
end
