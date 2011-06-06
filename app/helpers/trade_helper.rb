module TradeHelper
  def quest_links
    links = ""
    links << "<div style='position:absolute;top:500px;left:1000px'>"
    links << "#{link_to("enhancement shop", "enhancements/body")}" if @current_char.quest(2) && @current_char.quest(2).completed(@current_char.id)
    links << "</div>"
    links
  end
   
end
