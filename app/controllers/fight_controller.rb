class FightController < ApplicationController
  before_filter :login_required, :initiate


  def initiate
    @text= ["du bist tot", "mit einem schwung zerteilte er deinen kopf und lachte! \n.. und du dachtest du hörst ein lachen aber du tust es nicht denn.. DU BIST TOD  "]

  end

  def index
  end

  def fight
    @fight_data= ""
    c1 = Character.find_by_id(params[:char_1])
    c2 = Character.find_by_id(params[:attacked_char])
    item = Item.find_by_id(params[:item_id])
    c2_life = hit(c1, c2, item)


    flash[:notice]=@fight_data
    if c1.char_type == "user" && c1 == @current_char
      render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [c1.account_id.to_s]} do |page|
        @fighters=[c2]
        @attacked_char=c2
        @char=c1
        flash[:notice]=@fight_data
        if c2_life
          page["life_bar_#{c2.id}"].replace_html :partial => "characters/life_bar", :locals => {:char=> c2}
          #page["char_#{c1.id}_status_div"].replace_html "#{@regenerate_life_for_attacker}"
          page.insert_html :bottom, "char_#{c1.id}_status_div", "#{@regenerate_life_for_attacker}" if @regenerate_life_for_attacker
          page.insert_html :bottom, "char_#{c2.id}_status_div", "#{@dmg_for_defender}" if @dmg_for_defender
          #page["char_#{c2.id}_status_div"].replace_html "#{@dmg_for_defender}"   if @dmg_for_defender 
          page.insert_html :top, 'fight_data', "<li>^^^^^^^^^^^^^^^^^^</li>" if @fight_data
          page.insert_html :top, 'fight_data', "<li> #{ @fight_data}</li>" if @fight_data
          page["hit_#{c1.id}"].replace_html "#{javascript_tag("new Effect.Highlight('enemy_#{c2.id}_div',{ startcolor: '#{@start_color}',endcolor: '#{@end_color}' });")}"
        else
          c2.leave_fight
          location_sound = set_soundfile(@fight_data)
          location = "window.location=window.location.href.split('?')[0] + '#{location_sound}';"
          page.insert_html :top, 'notice', "#{ @fight_data}" if @fight_data
          page.insert_html :top, 'notice', "du hast gewonnen"
          page.insert_html :top, 'notice', "#{ c2.name } ist tot"
          page.insert_html :top, 'notice', javascript_tag("$('ajax_fight').value='false'")
          page["arena"].replace_html javascript_tag(location)
        end
      end
    end
    is_true = c2.quest_owner_id != 0 && !c2_life
    if is_true
      c2.destroy
    elsif c2.char_type == "user" && c2 == @current_char
      render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [c2.account_id.to_s]} do |page|
        @fighters=[c1]
        @attacked_char=c1
        @char=c2
        if c2_life
          page["life_bar_#{c2.id}"].replace_html :partial => "characters/life_bar", :locals => {:char=> c2}
          #page["char_#{c1.id}_status_div"].replace_html "#{@regenerate_life_for_attacker}"
          page.insert_html :bottom, "char_#{c1.id}_status_div", "#{@regenerate_life_for_attacker}" if @regenerate_life_for_attacker
          page.insert_html :bottom, "char_#{c2.id}_status_div", "#{@dmg_for_defender}" if @dmg_for_defender
          #page["char_#{c2.id}_status_div"].replace_html "#{@dmg_for_defender}" if @dmg_for_defender
          page.insert_html :top, 'fight_data', "<li>^^^^^^^^^^^^^^^^^^</li>" if @fight_data
          page.insert_html :top, 'fight_data', "<li> #{@fight_data}</li>" if @fight_data
          page["hit_#{c2.id}"].replace_html "#{javascript_tag("new Effect.Highlight('me_div',{ startcolor: '#{@start_color}',endcolor: '#{@end_color}' });")}"
        else
          c2.leave_fight
          flash[:notice]=@text[rand(1)]
          page.insert_html :top, 'notice', "#{@fight_data}" if @fight_data
          page.insert_html :top, 'notice', "#{c1.name } hat gewonnen"
          page.insert_html :top, 'notice', @text[rand(1)]
          location_sound = set_soundfile(@text[0])
          location = "window.location=window.location.href.split('?')[0] + '#{location_sound}';"
          page.insert_html :top, 'notice', javascript_tag("$('ajax_fight').value='false'")
          page["arena"].replace_html javascript_tag(location)
        end
      end
    end

    #render :nothing => true
  end


  def hit(a, d, item = nil)
    regenerate_life = a.regenerate_life_while_fight
    random_key_a = "random_c#{a.id}_#{rand(9999)}"
    @regenerate_life_for_attacker = regenerate_life == 0 ? false : "<div id='#{random_key_a}' class='shadow_only_text_green'>#{regenerate_life}</div><script>hide_div_after('#{random_key_a}',4);</script>"
    @fight_data = "#{a.name} regenerates #{regenerate_life}LP<br/>" if regenerate_life > 0
    a_buff_dmg_factor = a.ability_factor_for("dmg")
    d_buff_resist_factor = d.ability_factor_for("resist_dmg")
    random_number = rand(100)
    d_armor_factor = (d.armor / 1000)
    dmg = 0
    if !item
      if random_number < (a.cth - d.ctb)
        dmg = (a.damage - (a.damage * d_armor_factor))
        @fight_data << "#{a.name} trifft #{d.name} "
        @attack = "item_actions/hit.png"
        @start_color= "#ff0000"
        @end_color= "#000000"
      elsif random_number > (a.cth - d.ctb) && random_number < a.cth

        @fight_data << "#{d.name} blockt "
        @attack = "item_actions/block.png"
        @start_color= "#cccccc"
        @end_color= "#000000"
      elsif random_number > a.cth
        miss_hit = ((100 - random_number).to_f/100)
        miss_dmg = miss_hit * a.damage
        dmg = (miss_dmg - (miss_dmg * d_armor_factor))
        @fight_data << "#{a.name} streift #{d.name} "
        @attack = "item_actions/cut.png"
        @start_color= "#e77e7e"
        @end_color= "#000000"

      end
    else
      item.use_on(a, d)
    end
    if d_buff_resist_factor >= 1
      @fight_data << "schaden für #{d.name} absorbiert"
      @start_color= "#0000ff"
    end
    buff_dmg = dmg + (dmg * a_buff_dmg_factor)
    total_dmg = f2(buff_dmg - (buff_dmg * d_buff_resist_factor))
    random_key_d = "random_c#{d.id}_#{rand(9999)}"
    @dmg_for_defender = total_dmg <= 0 ? false : "<div id='#{random_key_d}' class='shadow_only_text_red'>#{total_dmg}</div><script>hide_div_after('#{random_key_d}',4);</script>"
    d.update_resist_dmg_buffs
    d.final_current_life=(d.final_current_life - total_dmg) if Quest.destroy_char_normal?(d)
    if d.final_current_life <= 0
      a.increase_gold(d.gold) if d.char_type == "enemy"
      a.items << d.items if a.char_type == "user"
      exp_gain = valid_exp(a, d)
      @fight_data << a.increase_exp(exp_gain)
      a.wins # increases win value
      a.save
      @fight_data << "für #{total_dmg} schaden" if total_dmg == 0
      if d.quest_owner_id != 0
        quest = d.belongs_to_quest # get quest
        #increas status of quest if no enemys are left
        increase_quest_step(quest.id, a.id) if Quest.last_enemy_for_this_status(a.id, quest.id)
      else
        d.current_life = d.max_life # regain full energy
        d.lost # increases lose value
        if d.char_type == "user"
          d.move_dead_char
        else
          d.char_type == "enemy"
          cd = d.coordinates
          cd.active = false
          cd.save
        end

        d.save
      end

      #if defender is quest_char
      return false
    elsif d.final_current_life > 0
      d.save
      total_dmg > 0 ? @fight_data << "für #{total_dmg} schaden" : (@fight_data = false if regenerate_life <= 0)
      return true
    end
  end

  def increase_quest_step(quest_id, user_char_id)
    Quest.set_status_for_user_char(quest_id, user_char_id, Quest.status_for_user_char(user_char_id, quest_id) + 1)
  end

  def valid_exp(a, d)
    exp =
            if a.level < d.level
              d.max_life + (d.max_life * ((d.level - a.level) / 10))
            elsif a.level >= d.level
              d.max_life - (d.max_life * ((a.level - d.level) / 25))
            end
    return exp
  end


end