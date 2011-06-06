class Armor < ActiveRecord::Base
  has_many :item_bonis, :as =>:owner  ,:dependent => :destroy
  #accepts_nested_attributes_for :item_bonis, :allow_destroy => true
  has_many :character_to_armor, :order=>"id asc", :dependent => :destroy
  has_many :character, :through => :character_to_armor

  def sell_price_for(char)
    self.worth * char.sell_ratio || 0
  end
  def buy_price_for(char)
    self.worth * char.buy_ratio || 0
  end
end
