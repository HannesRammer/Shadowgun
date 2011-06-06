class BodyPart < ActiveRecord::Base
  has_many :item_bonis, :as =>:owner  ,:dependent => :destroy
  accepts_nested_attributes_for :item_bonis, :allow_destroy => true
  def sell_price_for(char)
    self.worth * char.sell_ratio || 0
  end
  def buy_price_for(char)
    self.worth * char.buy_ratio || 0
  end
  def pic(gender)
    "enhancements/body/#{gender}_#{self.name}v#{self.version}.png"
  end
 

end
