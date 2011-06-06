class PathToVocationToAbility < ActiveRecord::Base
  belongs_to :path
  belongs_to :vocation
  belongs_to :ability
end
