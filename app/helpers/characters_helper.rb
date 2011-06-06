module CharactersHelper
  def compare_level(char, enemy)
    difference = level_difference(char, enemy)
    if difference <= -5
      "ultra"
    elsif difference > -5 && difference <= -3
      "asso"
    elsif difference > -3 && difference <= 1
      "hard"
    elsif difference > 1 && difference <= 3
      "you"
    elsif difference > 3 && difference <= 5
      "easy"
    elsif difference > 5
      "nothing"
    end
  end

  def ability_level_color(level)
    if level >= 50
      "ultra"
    elsif level >= 40 && level < 50
      "asso"
    elsif level >= 30 && level < 40
      "hard"
    elsif level >= 20 && level < 30
      "you"
    elsif level >= 10 && level < 20
      "easy"
    elsif level < 10
      "nothing"
    end
  end

  def ability_level_color_code(level)
    if level >= 50
      "cc0000"
    elsif level >= 40 && level < 50
      "ff6600"
    elsif level >= 30 && level < 40
      "ffff00"
    elsif level >= 20 && level < 30
      "7cb7f1"
    elsif level >= 10 && level < 20
      "00ff00"
    elsif level < 10
      "aaaaaa"
    end
  end

  def level_difference(char, enemy)
    char - enemy
  end

  def char_image_tag(char, opts = {}, size="small")
    
    size = "_#{size}" if !size.blank? 
    way = "right#{size}"
    if char.char_type == "enemy"
      a=["kyo_#{way}.gif","iori_#{way}.gif"]
      image_tag("character/#{a[rand(1)]}",opts)
    elsif char.char_type == "trader"
      a=["athena_#{way}.gif"]
      image_tag("character/#{a[0]}",opts)
    elsif char.char_type == "user"
        a=["hannes_stop#{size}.gif"]
      image_tag("character/#{a[0]}",opts)
    end
    #image_tag("#{char.char_type}.gif",opts)

  end

  def char_backend_image_tag(char, opts = {}, size="small")
    way = "right_#{size}"
    it = nil

    html = ""
    html << "<div onclick='toggleClass($(\"char#{char.id}\"),\"item_details_off open\",\"item_details_on close\");'>
                <div id='char#{char.id}' class='item_details_off open' >"
     html << render(:partial => 'characters/attributes', :locals=>{ :character => char})
    html << "</div></div>"
    return html
  end

   def grouped_ability_list_box(abilities, active = false)
    group = ""
    html = ""
    list = abilities
    active ? style = "width:300px;height:20px;float:left" : style = "width:300px;height:200px;float:left"
    return unless list
    list.each_with_index do |x, i|
      html << "<br/>"
      if group != x.group
        html << "<div style='#{style}'>"
        html << "<br/>"
        html << "#{x.group}<br/>"
        group = x.group
      end
      html << buff_div_tag(x, x.level)

      html << "</div>" if ((i + 1) < list.length) && (x.group != list[i + 1].group)
    end
    html << "</div>"
    return html
  end

end
