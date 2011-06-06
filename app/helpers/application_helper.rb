# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #float to float with chosen length
  def f(x, length_after_point)
    "%.#{length_after_point}f" % x
  end

  def f2(x)
    f(x, 2)
  end

  def flex_button(partial, css_id, char)
    "<div class='buttons'>
    #{render :partial => partial }
    </div>
     <div id='decount_#{css_id}_empty'></div>
    <div id='decount_#{css_id}_full'></div>  "

  end

  def life_bar(char)
    flex_bar(char, "life")
  end

  def xp_bar(char)
    flex_bar(char, "xp")
  end

  def flex_bar(char, css_class)
    number = eval "char.#{css_class}_in_percent"
    "<div class='#{css_class}_background' style='height:10px;width:100px;'>
        <div class='#{css_class}' style='height:10px;width:#{f2(number)}%;' >
        </div>
      </div>
      #{char == @current_char ? "#{f2(char.final_current_life) }/#{f2(char.final_max_life)}" : "???/???"} "
  end

  def within_range?(attacker, defender, range)
    ax=attacker.coordinates.x
    ay=attacker.coordinates.y
    dx=defender.coordinates.x
    dy=defender.coordinates.y
    x_min = ax - range
    x_max = ax + range
    y_min = ay - range
    y_max = ay + range
    dx < x_max && dx > x_min && dy < y_max && dy > y_min ? true : false
  end

  def attack_range?(attacker, defender)
    within_range?(attacker, defender, 50)
  end

  def bubble_render(page, pc_char, current_char, dialog)
    page["world_move_div"].replace_html :partial => "world/talk"
    page["navi"].replace_html ""
    user_info= generate_monologs(dialog, pc_char, current_char, "pc")
    user_dialoge = user_info[0]
    pc_info = generate_monologs(dialog, pc_char, current_char, "user")
    pc_dialoge = pc_info[0]
    page["bubble1"].replace_html user_dialoge
    page["bubble2"].replace_html pc_dialoge
  end

  def compass
    compass = "<div style='position:absolute;top:0;left:300px;'>"
    cc = Coordinates.compass_for(@current_char)
    compass << "#{image_tag("/images/icons/#{cc[1]}#{"_" if !cc[0].blank? && !cc[1].blank?}#{cc[0]}.png", :style=>"")}"
    compass << "</div>"
  end

  def current_area_color(area)
    if area == "wasser"
      "#0000ff"
    elsif area == "berg"
      "#cccccc"
    elsif area == "wald"
      "#00ff00"
    elsif area == "town"
      "#ffff00"
    elsif area == "room"
      "#ffffff"
    elsif area == "error"
      "#ff0000"
    elsif area == "exit"
      "#000000"
    end
  end

  def set_soundfile(flash_output_txt)
    if flash_output_txt.include?("level up")
      "?level_up=true"
    elsif flash_output_txt.include?("du bist tot")
      "?tot=true"
    else
      ""
    end
  end

  def start_fight_button(attacking_char_id, defender_char_id)
    "#{form_remote_tag(:before=> "$('ajax_move').value='false';",
                       :url => {:controller=> :world,
                                       :action => :start_fight,
                                       :char_1=> attacking_char_id,
                                       :attacked_char=> defender_char_id}) }
    #{submit_tag "fight" }
     </form> "
  end

  def start_dialog_button(pc_char_id)
    "#{form_remote_tag(:url => {:controller=> :dialogs,
                                       :action => :start_dialog,
                                       :pc_char_id=> pc_char_id}) }
    #{submit_tag "laber" }
     </form>"
  end

  def effect_box(char)

    "<div id='c#{char.id}_effect_div' style='height:0px;width:0px;position:absolute;'>
      </div>
<div id='c#{char.id}_effect_script_div'>
      </div>"

  end

  def field_name(field)
    if field.index("town") == 0 || field.index("room") == 0
      am = AreaMap.find_by_id(field.split("_")[1])
      am.name == "" ? field : am.name
    else
      field
    end
  end

  def is_world?(field)
    if field.include?("town") || field.include?("room")
      false
    else
      true
    end
  end

  #xy
  def fix_char_positioning(size)
    if size == "small"
      [21, 14]
    elsif size == "midi"
      [30, 22]
    else
      [62, 45]
    end
  end

 def awtc_value(char)
   "#{char.active_weapon && char.active_weapon.damage_type || "close"}_#{char.active_weapon && char.active_weapon.range || "2"}"
 end
end
