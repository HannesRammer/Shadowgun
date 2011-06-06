class RaceToPath < ActiveRecord::Base
  belongs_to :path
  belongs_to :race
end
