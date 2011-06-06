class InventarController < ApplicationController
  before_filter :login_required
  #before_filter :load_user
  def use
    item_type = params[:id].split("_")[1]
    item_to_char_id = params[:id].split("_")[2]
    if item_type == "weapon"
      item_to_char = CharacterToWeapon.find_by_id(item_to_char_id)
    else
      item_to_char = CharacterToArmor.find_by_id(item_to_char_id)
    end
    item = @current_char.use_item(item_to_char)
#    item_to_char = CharacterToArmor.find_by_id(item_to_char_id)

    render :update do |page|

      page["inventar_box"].replace_html :partial => "inventar/box"
      page["inventar_head_id"].replace_html :partial => "inventar/head", :locals=>{:htc=>@current_char.char_to_active_head}
      page["inventar_body_id"].replace_html :partial => "inventar/body", :locals=>{:btc=>@current_char.char_to_active_body}
      page["inventar_weapon_id"].replace_html :partial => "inventar/weapon", :locals=>{:wtc=>@current_char.char_to_active_weapon}
      page["inventar_shield_id"].replace_html :partial => "inventar/shield", :locals=>{:stc=>@current_char.char_to_active_shield}

      if item_type == "weapon"
        range_type = "<input type='hidden' id='aw_type_c#{@current_char.id}' name='aw_type_c#{@current_char.id}' value='#{@current_char.active_weapon.damage_type}_#{@current_char.active_weapon.range}'>"
        page["active_weapon_type_c#{@current_char.id}"].replace_html range_type 
      end

      # page["buttons"].replace_html :partial => "fight/buttons", :locals=>{   :character => char}
      # page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{  :wtcs => char.character_to_weapon}
      # page["results"].replace_html :partial => "characters/results", :locals=>{  :character => char}

      page["notice"].replace_html "#{item.name } wird benutzt."
    end
  end

  def remove
    type = params[:id].split("_")[1]
    item = @current_char.active_item(type)
    @current_char.unuse_item(type)
    render :update do |page|
      page["inventar_box"].replace_html :partial => "inventar/box"
      page["inventar_head_id"].replace_html :partial => "inventar/head", :locals=>{:htc=>@current_char.char_to_active_head}
      page["inventar_body_id"].replace_html :partial => "inventar/body", :locals=>{:btc=>@current_char.char_to_active_body}
      page["inventar_weapon_id"].replace_html :partial => "inventar/weapon", :locals=>{:wtc=>@current_char.char_to_active_weapon}
      page["inventar_shield_id"].replace_html :partial => "inventar/shield", :locals=>{:stc=>@current_char.char_to_active_shield}

      # page["buttons"].replace_html :partial => "fight/buttons", :locals=>{   :character => char}

      #page["weapons"].replace_html :partial => "weapons/user_index", :locals=>{  :wtcs => char.character_to_weapon}
      # page["results"].replace_html :partial => "characters/results", :locals=>{  :character => char}
      page["notice"].replace_html "#{item.name} in inventar abgelegt."
    end
  end
end
