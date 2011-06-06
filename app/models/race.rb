class Race < ActiveRecord::Base
  has_many :race_to_path, :order=>"id asc"
  has_many :paths, :through => :race_to_path
end
