class Item < ActiveRecord::Base
  has_many :item_bonis, :as =>:owner, :dependent => :destroy
  # accepts_nested_attributes_for :item_bonis, :allow_destroy => true

  # price depends on user_char attributes
  # when selling; price = item.sell_price_for(user_char)
  # when buying; price = item.buy_price_for(user_char) not item.sell_price_for(pc_char)
  def sell_price_for(char)
    self.worth * char.sell_ratio || 0
  end
  def buy_price_for(char)
    self.worth * char.buy_ratio || 0
  end

  def use_on(item_user, item_used_on=nil)
    if item_used_on
      if self.name == "Heiliges Abführmittel" && item_used_on.name == "TP-MAN"
        item_used_on.current_life = 0
        item_used_on.save
      end
    end
    if self.name == "Heiltrank"
      item_user.increase_current_life_by(100)
    end
    used(item_user.id, self.id)

  end

  private
  def used(char_id, item_id)
    cti = CharacterToItem.find_by_character_id_and_item_id(char_id, item_id)
    cti.destroy
  end
end
