class Path < ActiveRecord::Base
  has_many :path_to_vocation, :order=>"id asc"
  has_many :vocations, :through => :path_to_vocation
end
