class Character < ActiveRecord::Base
  belongs_to :account

  has_one :coordinates, :dependent => :destroy

  #used if user_character
  has_many :userchar_to_quest, :order=>"quest_id asc", :dependent => :destroy
  has_many :quests, :through => :userchar_to_quest

  has_many :quest_characters, :dependent => :destroy
  has_one :belongs_to_quest, :through => :quest_characters, :source=>:quest

  has_many :character_to_current_fight, :dependent => :destroy
  has_one :current_fight, :through => :character_to_current_fight


  has_many :character_to_race, :dependent => :destroy
  has_one :race, :through => :character_to_race

  has_many :character_to_path, :dependent => :destroy
  has_one :path, :through => :character_to_path

  has_many :character_to_vocation, :dependent => :destroy
  has_one :vocation, :through => :character_to_vocation

  has_many :character_to_body_part, :order=>"id asc"
  has_many :body_parts, :through => :character_to_body_part

  has_many :character_to_weapon, :order=>"id asc", :dependent => :destroy
  has_many :weapons, :through => :character_to_weapon

  has_many :character_to_item, :order=>"id asc", :dependent => :destroy
  has_many :items, :through => :character_to_item

  has_many :character_to_armor, :order=>"id asc", :dependent => :destroy
  has_many :armors, :through => :character_to_armor

  named_scope :user_chars, :conditions=>{:char_type=>'user'}

  def final_body
    body = self.body
    x = body + (body * self.ability_factor_for("body"))
    x
  end

  def final_mind
    mind = self.mind
    x = mind + (mind * self.ability_factor_for("mind"))
    x
  end

  def final_agility
    agility = self.agility
    x = agility + (agility * self.ability_factor_for("agility"))
    x
  end

  def final_charisma
    charisma = self.charisma
    x = charisma + (charisma * self.ability_factor_for("charisma"))
    x
  end

  def final_psychic
    psychic = self.psychic
    x = psychic + (psychic * self.ability_factor_for("psychic"))
    x
  end

  def load_first_quest
    Quest::Quest1.preload(self.id)
    # moved to end of quests
    #Quest::Quest2.preload(self.id) if !self.has_quest?(2)
    #Quest::Quest3.preload(self.id) if !self.has_quest?(3)
  end

  def current_area
    x = self.coordinates.x
    y = self.coordinates.y
    f = self.coordinates.field
    am = AreaMap.find_by_sql("select * from area_maps where field = '#{f}' and x_min < #{x} and  (x_min + x_max) > #{x} and y_min < #{y} and ( y_min + y_max ) > #{y} limit 1")[0]
    am ? am.field_type : "field"

  end

  def active_items
    c_to_items = self.character_to_item.collect { |x| x if x.active }
    c_to_items << nil
    c_to_items.compact!
    x = c_to_items.collect { |x| x.item }
  end

  def self.generate_character(account)
    char = self.new(:char_type => "user", :gender=>"female", :name=>account.username)
    if char.save
      char.load_first_quest

      msg ="*Charakter generiert*"
      account.character = char
      if account.save
        msg << "*User updated*"

        c = Coordinates.new()
        c.x = rand(300)
        c.y = rand(300)
        c.character_id = char.id
        if c.save
          msg << "*coordinaten generiert*"
        end
      end
      return msg
    else
      return account.errors.full_messages
    end
  end

  def race_name
    self.race ? self.race.name : ""
  end

  def race_id
    self.race ? self.race.id : 0
  end

  def path_name
    self.path ? self.path.name : ""
  end

  def path_id
    self.path ? self.path.id : 0
  end

  def vocation_name
    self.vocation ? self.vocation.name : ""
  end

  def vocation_id
    self.vocation ? self.vocation.id : 0
  end

  def ability_list
    abilities = []
    ptvta = PathToVocationToAbility.find_all_by_path_id_and_vocation_id(self.path_id, self.vocation_id)
    abilities = ptvta.collect { |x| x.ability } if ptvta
    abilities
  end

  def active_ability_ids
    abs = self.ability_list.collect { |ability| ability if ability.level.to_i <= self.level.to_i }.compact
    groups = {}
    active_abs = []
    return unless abs
    #find biggest
    abs.each do |a|
      groups[a.group] = a.id if groups[a.group].nil? || groups[a.group].to_i < a.id
    end
    # collect ids
    groups.each do |group, id|
      active_abs << id
    end
    active_abs
  end

  def active_ability_list
    Ability.find_all_by_id(self.active_ability_ids)
  end

  def active_abilities_for(usage_type)
    abilities =[]
    time = Time.now
    self.ctaas(usage_type).each do |x|
      x
      if x.valid_till > time && x.valid_from <= time && (x.valid_times.nil? || x.valid_times > 0)
        abilities << x.ability
      else
        #x.destroy
      end
    end
    abilities
  end

  def active_ability_ids_for(usage_type)
    ids = active_abilities_for(usage_type).collect { |x| x.id }
    ids

  end

  def ability_factor_for(usage_type)
    ids = self.active_ability_ids_for(usage_type)
    value = (0).to_f
    Ability.find_all_by_id(ids).each do |x|
      value += x.factor
    end
    value = ("%.2f" % (value / 100)).to_f
    value
  end

  def update_resist_dmg_buffs
    update_active_buffs_for("resist_dmg")
  end

  def update_healing_buffs
    return update_active_buffs_for("heal")
  end

  def ctaas(usage_type)
    CharacterToActiveAbility.find_all_by_character_id_and_usage_type(self.id, usage_type).collect { |x| x }
  end

  def update_active_buffs_for(usage_type)
    sum = 0
    self.ctaas(usage_type).each do |s|
      v_times = s.valid_times
      repeat = s.ability.repeat
      factor= s.ability.factor
      times = s.ability.active_times
      if repeat != -1
        time = Time.now
        repeat_at = s.valid_from + repeat.seconds
        if repeat_at < time
          s.valid_times = times
          s.valid_from = time
          s.valid_till = time + repeat.seconds
        else
          if v_times > 0
            s.valid_times -= 1
            sum += factor
          end
        end
        s.save
      else
        if s.valid_times


          if v_times == 1 || v_times
            sum += factor
            s.destroy
          else
            s.valid_times -= 1
            sum += factor
          end
        end
        s.save
      end
    end
    return sum
  end

  def self.generate(char, xyf = nil)
    e = Character.create(char)

    e.coordinates = Coordinates.new_coordinates(xyf)
    e
  end

  def random_attributes_for_level(x)
    max = (25 + (x - 1))
    extra_points = 0
    points_each = max / 5
    rest_points = max % 5
    self.max_ability_points = max
    %w{                    mind agility body charisma psychic                    }.each do |name|
      eval "extra_points = #{["-", "+"].rand}#{rand(2)}"
      rest_points -= extra_points
      eval "self.#{name} = #{points_each} + #{extra_points}"
      self.save
    end
    checksum = (max - (self.mind + self.body + self.agility + self.charisma + self.psychic))
    if checksum != 0 # if still points left
      name = %w{                    mind agility body charisma psychic                    }.rand
      eval "self.#{name} += #{checksum}"
      self.save
    end
    self.save
  end

  def free_attribute_points
    self.max_ability_points - (self.mind + self.agility + self.body + self.charisma + self.psychic)
  end

  def final_current_life
    self.current_life * self.enhanced_multiplier("chest")
  end

  def final_max_life
    x = self.max_life * self.enhanced_multiplier("chest")
    x
  end

  def final_current_life=(x)
    self.current_life = (x / self.enhanced_multiplier("chest"))
    self.save
  end

  def final_max_life=(x)
    self.max_life = (x / self.enhanced_multiplier("chest"))
    self.save
  end

  def life_in_percent
    (100 / self.final_max_life) * self.final_current_life
  end

  def xp_in_percent
    (100 / self.next_lev_exp) * self.current_exp
  end

  def damage
    var1 = ((self.final_agility/2) + (self.final_mind/3)+ (self.final_psychic/5)) / 2
    dmg_perc = self.cmd / 10
    dmg_char = (self.final_body + var1 + (self.level/10)) * dmg_perc
    dmg_char = dmg_char * self.enhanced_multiplier("arms")
    dmg_weapon = self.active_weapon_damage * (dmg_perc / 10)
    dmg = dmg_char + dmg_weapon
    return ("%.2f" % dmg).to_f
  end

  def armor
    #1
    body_armor = ("%.2f" % ((self.final_body * self.level)/10)).to_f
    #2
    full_armor = self.active_armors_protection + body_armor
    ability_armor = full_armor * self.ability_factor_for("armor")
    #3
    final_armor = full_armor + ability_armor
    return final_armor
  end

  def cth
    var2 =self.chance_to_hit + (self.final_psychic/2) + (self.final_agility/3) + self.level + (self.final_mind/2)
    return ("%.2f" % var2).to_f
  end

  def ctb
    chance_to_block = (self.final_psychic/3) + (self.final_agility/3) + self.level + (self.final_mind/4)
    return ("%.2f" % chance_to_block).to_f
  end

  def cmd
    var2 =self.chance_of_max_damage + (self.final_psychic/5) + (self.final_agility/2) + self.level + (self.final_mind/4)
    return ("%.2f" % var2).to_f
  end

  def buy_ratio
    buy_ratio_percent.to_f / 100
  end

  def buy_ratio_percent
    x = "%.2f" % (100 - (100 * self.final_charisma/295))
    return x.to_f
  end

  def sell_ratio
    sell_ratio_percent / 100
  end

  def sell_ratio_percent
    x = "%.2f" % (100/2 + (100 * self.final_charisma/295))
    return x.to_f
  end

  def lvl_up
    self.save
    while (self.current_exp >= self.next_lev_exp) do
      self.lvl_up_action
    end
  end

  def lvl_up_action
    self.level += 1
    self.current_exp -= self.next_lev_exp
    self.lvl_up_increase_life
    self.next_lev_exp = (((self.max_life) + (self.max_life/10 * (self.level / 2)))* 10)
    self.max_ability_points += 1
    self.save
  end

  def regenerate_life
    if self.current_life < self.max_life
      points = self.update_healing_buffs
      reg_in_10_sec = regenerate_life_per_second * 10
      sum = (reg_in_10_sec + points)
      increase_current_life_by(sum) if sum > 0
    end
  end

  def regenerate_life_while_fight
    x=0
    if self.current_life < self.max_life
      x=self.update_healing_buffs
      increase_current_life_by(x) if x > 0
    end
    x
  end

  def regenerate_life_per_second
    x = "%.2f" % ((((self.final_psychic/3) + (self.final_body/2) + (self.final_mind/4)) / 2) * self.enhanced_multiplier("heart"))
    return x.to_f
  end

  def lvl_up_increase_life
    lvl = self.level
    if lvl < 10
      gain = "1#{lvl}".to_f
    else
      lvl_life = "#{lvl/10}".split(".")
      gain = "#{lvl_life[0].to_i + 1}#{lvl_life[1]}".to_f
    end

    #gain = "1.#{lvl_life}".to_f
    increase_max_life(gain)
  end

  def increase_max_life(gain)
    flash = ""
    self.max_life += gain
    self.save ? flash << "max lebenspunkte um #{gain} auf #{self.max_life} gestiegen" : flash << "fehler in model/character.rb def increase_max_life(gain)"
    return flash
  end

  def increase_current_life_by(gain)
    flash = ""
    self.current_life += gain
    if self.current_life > self.max_life
      self.current_life = self.max_life
    end
    self.save ? flash << "lebenspunkte um #{gain} gestiegen" : flash << "fehler in model/character.rb def increase_max_life(gain)"
    return flash
  end

  def set_current_life_to(x)
    self.current_life = x
    self.save
  end

  def increase_exp(gain)
    flash = ""
    self.current_exp += gain
    self.save ? flash << "#{gain} exp bekommen" : flash << "fehler in model/character.rb def increase_exp(gain)"
    if self.current_exp >= self.next_lev_exp
      self.lvl_up
      flash << " level up "
    end
    return flash
  end

  def move_char(x, y, field)
    self.coordinates.x = x
    self.coordinates.y = y
    self.coordinates.field = field
    self.coordinates.save
  end

  def move_dead_char
    self.move_char(rand(100) + 180, rand(100) + 260, "2_3")
  end

# pick up weapon or armor or item
  def pick_up(item)
    return false if item.blank?
    eval "self.#{item.class.to_s.downcase}s << item"
    " #{item.name} bekommen"
  end

  def drop(item_to_char)
    return false if item_to_char.blank?
    item_to_char.destroy
  end

  def item_type(obj)
    if obj.class == CharacterToArmor
      obj.armor.armor_type
    elsif obj == "head" || obj == "body" || obj == "shield"
      obj
    elsif obj.class == CharacterToWeapon || obj == "weapon"
      "weapon"
    elsif obj.class == CharacterToItem || obj == "item"
      "item"
    end
  end

# use weapon or armor
  def use_item(new_item_to_char)
    return if new_item_to_char.blank?
    unuse_item(new_item_to_char) #sounds wired i know , read code below
    type = item_type(new_item_to_char)
    item_to_char = new_item_to_char.class.find_by_id(new_item_to_char.id) #hotfix as new_item_to_char seems to be stale every second time
    item_to_char.active = true
    if item_to_char.save!


      val = self.active_item(type)
      return val
    end
  end

# unuse item
  def unuse_item(new_active_item)
    return if new_active_item.blank?
    type = item_type(new_active_item) # find type of item for replacement
    c_active_item = eval "char_to_active_#{type}" #find active item for type
    if !c_active_item.blank?
      c_active_item.active = false
      c_active_item.save
    end
  end


# active_item returns item o bject
  def active_item(type)
    active_item = eval "char_to_active_#{type}"
    return false if active_item.blank?
    if type == "weapon"
      active_item.weapon
    else
      active_item.armor
    end
  end

  def active_weapon
    active_item = char_to_active_weapon
    return false if active_item.blank?
    active_item.weapon
  end

#char_to_active_item return CharToItem object
  def char_to_active_weapon
    return CharacterToWeapon.find_by_character_id_and_active(self.id, true)
  end

  def char_to_active_body
    char_to_active_inventar_item("body")
  end

  def char_to_active_head
    char_to_active_inventar_item("head")
  end

  def char_to_active_shield
    char_to_active_inventar_item("shield")
  end

  def char_to_active_inventar_item(item)
    value = false
    char_to_active_armors.each do |c|
      value = c if c.armor.armor_type == item
    end
    return value
  end

#return [CharToItem, CharToItem2, CharToItem3] array
  def char_to_active_armors
    return CharacterToArmor.find_all_by_character_id_and_active(self.id, true)
  end

#returns number
  def active_weapon_damage
    active_weapon ? active_weapon.damage : 0
  end

#returns array of active armor objects
  def active_armors
    ctaa = char_to_active_armors
    armor =[]
    ctaa.each do |aa|
      armor << aa.armor
    end
    return false if armor.blank?
    return armor
  end

#returns float
  def active_armors_protection
    protection = 0
    if active_armors
      active_armors.each do |a|
        protection += a.armor
      end
    end
    return ("%.2f" % protection).to_f
  end


  def hit_time?
    return active_weapon ? active_weapon.hit_time : 3
  end

  def inventar
    @items = []
    %w{                             weapon armor item                             }.each do |item|
      x = eval "CharacterTo#{item.capitalize}.find(:all, :select=>'#{item}_id',
                                                   :conditions=>'character_id=#{self.id} #{"and active = false" if item != "item"}',
                                                   :group=>'#{item}_id')"
      x.each do |c|
        w= eval "CharacterTo#{item.capitalize}.find_by_character_id_and_#{item}_id(self.id, c.#{item}_id)"
        wcount= eval "CharacterTo#{item.capitalize}.find_all_by_character_id_and_#{item}_id_and_active(self.id, c.#{item}_id, #{item == "item" ? "true" : "false" }).length"
        @items << [w, wcount]
      end
    end
    @items
  end

  def wins
    self.win += 1
    self.save
  end

  def lost
    self.lose += 1
    self.save
  end

  def exchange_money_to(seller, gold)
    self.decrease_gold(gold) ? seller.increase_gold(gold) : false
  end

  def increase_gold(gold)
    self.gold += gold || 0
    self.save
  end

  def decrease_gold(gold)
    if gold <= self.gold
      self.gold -= gold
      self.save
    else
      false
    end
  end

  def update_dialog(pc_char_id, dialog_set_id)
    DialogSet.set_dialog(self.id, pc_char_id, dialog_set_id)
  end

#pc char method
  def dialog(user_char_id, set_id = nil)
    return [] if set_id == -1
    dialogs = if set_id
                Dialog.find_all_by_set_id([set_id])
              else
                dialog_set_ids = DialogSet.find_all_by_user_char_id_and_pc_char_id(user_char_id, self.id).collect { |ds| ds.set_id } || [DialogSet..set_dialog(user_char_id, self.id, 2).set_id]
                Dialog.find_all_by_set_id(dialog_set_ids)
              end
    dialogs << Dialog.find_by_set_id(0)
  end

  def add_quest(quest_id)
    quest_id = (quest_id.to_i / 1000)
    if quest_id && UsercharToQuest.find_by_character_id_and_quest_id(self.id, quest_id).blank?
      quest = eval "Quest::Quest#{quest_id}.create_for_user(self.id)"
      if self.quests << quest
        Quest.set_status_for_user_char(quest.id, self.id, 1)
        return "quest bekommen :)"
      else
        return "nicht gespeichert #fehler"
      end
    else
      return "quest vorhanden"
    end
  end

  def body_pics
    body=["enhancements/body/#{self.gender}_unmod.png"]
    self.body_parts.each do |bp|
      body << bp.pic(self.gender)
    end
    body
  end

  def enhancment(body_part_name)
    self.body_parts.collect { |bp| bp if bp.name == body_part_name }.compact[0]
  end

  def enhanced_multiplier(body_part_name)
    self.enhancment(body_part_name) && self.enhancment(body_part_name).multi || 1
  end

  def attention
    x=(self.enhanced_multiplier("eyes") + (self.enhanced_multiplier("brain")/2))/2
    10 - x
  end

  def moving_speed_while_fight_per_second
    m_per_sec = ((self.enhanced_multiplier("legs") * (self.agility/self.body)) + (self.level/100))
    ("%.2f" % m_per_sec).to_f
  end

  def moving_speed_while_fight_per_meter
    m_per_sec = ((self.enhanced_multiplier("legs") * (self.agility/self.body)) + (self.level/100))
    ("%.2f" % (1 / m_per_sec)).to_f
  end

#gets unique database quest id from non unique and user_char_id
  def unique_quest_id(game_quest_id)
    self.quests.collect { |q| q if q.quest_id == game_quest_id.to_i }[((game_quest_id / 1000) - 1)].id
  end

  def quest(quest_id)
    ctq = UsercharToQuest.find_by_character_id_and_quest_id(self.id, quest_id)
    ctq ? ctq.quest : false
  end

  def has_enhancement?(body_part_id)
    CharacterToBodyPart.find_by_body_part_id_and_character_id(body_part_id, self.id) ? true :false
  end

  def next_goal
    return Character.find_by_name("quest_1_friend") unless first_uncompleted_quest = self.quests.collect { |q| q if !self.completed_quest?(q) }.compact[0]
    first_uncompleted_quest.status_for_user_char(self.id)
    first_uncompleted_quest_first_active_enemy = Quest.active_quest_enemies(self.id, first_uncompleted_quest.quest_id)[0]
    return first_uncompleted_quest_first_active_enemy
  end

  def has_quest?(quest_id)
    !Quest.status_for_user_char(self.id, quest_id).nil?
  end

  def completed_quest?(quest)
    quest.completed(self.id)
  end

  def can_swim?
    false
  end

  def can_climb?
    true
  end

  def allowed_move_char(x, y, coordinates, way, town_room="")
    field_is_new = false
    field = coordinates.field
    if way== "move"
      if !Coordinates.valid_field_path(x, y)
        new_coordinates = Coordinates.find_new_field(x, y, field)
        x = new_coordinates[0]
        y = new_coordinates[1]
        field = new_coordinates[2]
        field_is_new = true
      end
      allow_area?
      if AreaMap.allow_area_for(self, AreaMap.area_for(x, y, field))
        coordinates.x = x
        coordinates.y = y
        coordinates.field = field
        coordinates.save
      end
    elsif way== "town"
      coordinates.field = "#{way}_#{town_room}"
      coordinates.save
    elsif way == "load"

    end
    return [coordinates.x, coordinates.y, coordinates.field, field_is_new]
  end

  def allow_area?

  end

  def leave_fight
    cf = self.current_fight
    cf.leave_fight(self)
  end

  def last_two_in_fight?
    cf = self.current_fight
    return true unless cf 
    cf.last_two_fighters?
  end
end
