module InventarHelper

  def item_image_tag(item)
    name = item.name
    clean_name = name.gsub("ü", "ue").gsub("ä", "ae").gsub("ö", "oe").strip
    html = ""
    html << "<div>#{image_tag("items/#{clean_name}.png")}
                <div class='item_details_off open'
                     onclick='toggleClass(this,\"item_details_off open\",\"item_details_on close\");'><br/>"
    item.attributes.each do |k, v|
      if k != "updated_at" && k != "created_at" && k != "id" && k != "active" && k != "armor_type" && k != "damage_type"
        html << "<div class='title'>#{k}</div>"
        html << "<div class='text'>#{v}</div>"
      end
    end
    html << "</div></div>"
  end                                   

  def action_item_image_tag(name, browse = "items", ending = "png")
    clean_name = name.gsub("ü", "ue").gsub("ä", "ae").gsub("ö", "oe")
    html = image_tag("#{browse}/#{clean_name}.#{ending}")

  end

  def item_div_tag(item, count, text=false)
    clean_name = item.name.gsub("ü", "ue").gsub("ä", "ae").gsub("ö", "oe")
    item_css_id = "#{item.name.gsub(' ','_')}_item_#{item.id}"
    html = ""
    html << "<div class='item' id='#{item_css_id}' onclick='toggleClass($(\"item_#{item.id}_details\"),\"closed\",\"item_details_on\");' oncontextmenu='toggleClass($(\"item_#{item.id}_menu\"),\"closed\",\"item_menu_on\");return event.ctrlKey' >"
    html << "<div>#{text ? clean_name : image_tag("items/#{clean_name}.png")}
                <div id='item_#{item.id}_details' class='closed'>"

    item.attributes.each do |k, v|
      if k != "updated_at" && k != "created_at" && k != "id" && k != "active" && k != "armor_type" && k != "damage_type"
        html << "<div class='title'>#{k}</div>"
        html << "<div class='text'>#{v}</div>"
      end
    end
    html << "</div></div>"

    html << "<div class='#{text ? "text_number" : "number" }'>"
    html << "#{count}"
    html << "</div>"

    html << "<div id='item_#{item.id}_menu' class='closed'>"
    html << "<div class='title'>"
    html << "#{link_to_remote("use #{item.name}", :url => { :controller => :items, :action=>:use_on_me, :item_id=>item.id})}"
    html << "</div></div>"
    html << "</div>"
  end

  def buff_div_tag(item, count, text=false )
     clean_name = item.group.gsub("ü", "ue").gsub("ä", "ae").gsub("ö", "oe")
     item_css_id = "#{item.name.gsub(' ','_')}_item_#{item.id}"
     html = ""
     html << "<div class='item' id='#{item_css_id}' onclick='toggleClass($(\"item_#{item.id}_details\"),\"closed\",\"item_details_on\");' oncontextmenu='toggleClass($(\"item_#{item.id}_menu\"),\"closed\",\"item_menu_on\");return event.ctrlKey' >"
     html << "<div>#{text ? clean_name : image_tag("buffs/#{clean_name}.png")}
                 <div id='item_#{item.id}_details' class='closed'>"

     item.attributes.each do |k, v|
       if k != "updated_at" && k != "created_at" && k != "id" && k != "active" && k != "armor_type" && k != "damage_type"
         html << "<div class='title'>#{k}</div>"
         html << "<div class='text'>#{v}</div>"
       end
     end
     html << "</div></div>"

     html << "<div class='#{text ? "text_number" : "number" }'>"
     html << "#{count}"
     html << "</div>"

     html << "<div id='item_#{item.id}_menu' class='closed'>"
     html << "<div class='title'>"
     html << "#{link_to_remote("use #{item.name}", :url => { :controller => :items, :action=>:use_on_me, :item_id=>item.id})}"
     html << "</div></div>"
     html << "</div>"
   end



end
