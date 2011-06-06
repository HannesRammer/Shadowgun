class TradeController < ApplicationController
  before_filter :login_required

  def start_trade
    seller = Character.find_by_id(params[:char_1])
    buyer = Character.find_by_id(params[:attacked_char])
    if seller.char_type == "user"
      render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [seller.account_id.to_s]} do |page|
        @trader = buyer
        @char=seller
        page["world_move_div"].replace :partial => "trade/shop"
        page["message"].replace_html ""
        page["navi"].replace_html ""#:partial =>"trade/action_bar"
        page["music"].replace_html '<embed src="/gamemusic/klingelton10.wma" hidden="true" autostart="true" LOOP=99 PLAYCOUNT=99>;'
      end
    end
    if buyer.char_type == "user"
      render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [buyer.account_id.to_s]} do |page|
        @trader = seller
        @char=buyer
        page["world_move_div"].replace :partial => "trade/shop"
        page["message"].replace_html ""
        page["navi"].replace_html ""#:partial =>"trade/action_bar"
        page["music"].replace_html '<embed src="/gamemusic/klingelton10.wma" hidden="true" autostart="true" LOOP=99 PLAYCOUNT=99>;'
      end
    end
#    render :nothing => true
  end

  ############################
  #user_char <-> pc_char only
  def trade

    buyer = Character.find_by_id(params[:buyer])
    seller = Character.find_by_id(params[:seller])
    type = params[:item].split("_")[1]
    type_id = params[:item].split("_")[2]
    type = type == "head" || type == "body" || type == "shield" ? "armor" : type
    char_to_obj = eval "CharacterTo#{type.capitalize}.find_by_id(type_id)"
    char_to_obj.character_id = buyer.id
    item = eval "char_to_obj.#{type}"
    char_to_obj.save
    # price depends on user_char attributes
    # when selling; price = item.sell_price_for(user_char)
    # when buying; price = item.buy_price_for(user_char) not item.sell_price_for(pc_char)
    exchange = buyer.char_type == "user" ? buyer.exchange_money_to(seller, item.buy_price_for(buyer)) : buyer.exchange_money_to(seller, item.sell_price_for(seller))
    if exchange
      if seller.char_type == "user"
        render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [seller.account_id.to_s]} do |page|
          @trader = buyer
          @char=seller
          page["shop"].replace :partial => "trade/shop"
          page["notice"].replace_html "#{item.name} wechselt für #{f2(item.sell_price_for(@char))} gold den besitzer"
          page["inventar_box"].replace_html :partial => "/inventar/box"
        end
      elsif buyer.char_type == "user"
        render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [buyer.account_id.to_s]} do |page|
         @trader = seller
         @char=buyer
         page["shop"].replace :partial => "trade/shop"
         page["notice"].replace_html "#{item.name} wechselt für #{f2(item.buy_price_for(@char))} gold den besitzer"
         page["inventar_box"].replace_html :partial => "/inventar/box"
        end
      end
      # render :nothing => true
    else
      ok("nicht genug gold")
    end
  end
end
