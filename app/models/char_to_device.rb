class CharToDevice < ActiveRecord::Base
  belongs_to :character
  belongs_to :digi_device
end
