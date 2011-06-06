module DialogsHelper
  def dialog_link(dialog, pc_char, user)
    if dialog.dialog_type == "user"
      user_dialog(dialog, pc_char)
    elsif dialog.dialog_type == "quest"
      quest_dialog(dialog, pc_char, user)
    else
      pc_dialog(dialog)
    end
  end

  def user_dialog(dialog, pc_char)
    url = {:controller => :dialogs,
           :action => :start_dialog,
           :pc_char_id => pc_char,
           :set_id => dialog.next_set_id}
    link_to_remote(dialog.text, :url=>url, :html=>{:class=>"shadow_only_text_black"})
  end

  def quest_dialog(dialog, pc_char, user)
    url = {:controller => :quests,
           :action => dialog.action,
           :pc_char_id => pc_char,
           :user_id => user,
           :new_set_id => dialog.next_set_id,
           :old_set_id => dialog.set_id,
           :quest_id => ((dialog.set_id / 1000) * 1000)}
    link_to_remote(dialog.text, :url=>url, :html=>{:class=>"shadow_only_text_black"})
  end

  def pc_dialog(dialog)
    "<span class='char_dialog'> #{dialog.text}</span>"
  end

  def generate_dialogs(dialogs, pc_char, user_char)
    html = ""
    pc = 0
    user = 0
    dialogs.each do |dialog|
      if dialog.dialog_type == "trader" && pc == 0
        html << "<li class='char_name'>#{pc_char.name}:</li>"
        pc = 1
      elsif dialog.dialog_type != "trader" && user == 0
        html << "<li class='char_name'>#{user_char.name}:</li>"
        user = 1
      end
      html << "<li>"
      html << dialog_link(dialog, pc_char.id, user_char.id)
      html << "</li>"
    end
    html
  end

  def generate_monologs(monologs, pc_char, user_char, type)
    html = ""
    length=0
    pc_char_id = pc_char && pc_char.id
    user_char_id  = user_char && user_char.id
    if type == "pc"
      html << "<li class='msg_actions'>#{link_to_remote("handel mit #{pc_char.name}",
                                                        :html => {:class  => "shadow_only_text_black"},

                                                        :url => {:controller=> :trade,
                                                                 :action => :start_trade,
                                                                 :char_1=> user_char.id,
                                                                 :attacked_char=> pc_char.id}) } </li>"

    end
    monologs.each do |monolog|
      mono_array = monolog_link(monolog, pc_char_id, user_char_id, type)
      html << "#{mono_array[0]}"
      length = mono_array[1]
    end
    [html, length]
  end

  def monolog_link(monolog, pc_char, user, type)
    list= ""
    length=0
    if type == "user"
      if monolog.dialog_type == "user"
        list << "<li>"
        list << user_dialog(monolog, pc_char)
        list << "</li>"
        length += 1
      elsif monolog.dialog_type == "quest"
        list << "<li>"
        list << quest_dialog(monolog, pc_char, user)
        list << "</li>"
        length += 1
      end
    elsif type== "pc"
      if monolog.dialog_type == "trader"
        list << "<li>"
        list << pc_dialog(monolog)
        list << "</li>"
        length += 1
      end
    end
    [list, length]
  end

end
