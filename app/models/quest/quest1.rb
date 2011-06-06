module Quest::Quest1
  def self.final_status
    4
  end

  #
  #initiated only once
  def self.first_time_initiate
    params = {"friend"=>{"name"=>"quest_1_friend",
                         "char_type"=>"trader",
                         "gold"=>999999},
              "coordinates"=>{"x"=>200, "y"=>200, "field"=>"1_2"}}
    f = Character.find_by_name("quest_1_friend") || Character.create(params["friend"])
    f.coordinates = Coordinates.new_coordinates(params["coordinates"])
    999.times do
      f.items << Item.all
      f.weapons << Weapon.all
      f.armors << Armor.all
    end
    user_chars = Character.user_chars
    if !user_chars.blank?
      user_chars.each do |user_char|
        Quest::Quest1.preload(user_char.id)
      end
    end
  end

  #
  #initiated for each user
  def self.preload(user_char_id)
    DialogSet.set_dialog(user_char_id,Character.find_by_name("quest_1_friend").id,1000)
  end

  #
  #initiated for each user
  def self.create_for_user(user_char_id)
    params = {"spanner"=>{"name"=>"spanner",
                       "char_type"=>"enemy",
                       "gold"=>999,
                       "quest_owner_id"=>user_char_id,
                       "active_quest_status"=>1},
              "susi"=>{"name"=>"susi",
                       "char_type"=>"trader",
                       "gold"=>999999,
                       "quest_owner_id"=>user_char_id,
                       "active_quest_status"=>2},
              "quest"=>{"gold"=>100, "exp"=>1000, "title"=>"Aller anfang is schwer!", "quest_id"=> 1000}}
    q = Quest.find_by_quest_id(1000) || Quest.create(params["quest"])
    q.save
    e = Character.create(params["spanner"])
    opts_e={"x"=>425,"y" =>140,"field"=> "1_2"}
    e.coordinates = Coordinates.new_coordinates(opts_e)
    q.characters << e
    ff = Character.create(params["susi"])
    opts_ff={"x"=>e.coordinates.x + 10,"y" =>e.coordinates.y - 10,"field"=> "1_2"}
    ff.coordinates = Coordinates.new_coordinates(opts_ff)
    q.characters << ff
    DialogSet.set_dialog(user_char_id,ff.id, 1011)
    return q
  end

  def self.update_for_user(user_char_id)
    pc=Character.find_by_name("quest_1_friend")
    susi=Character.find_by_name_and_quest_owner_id("susi",user_char_id)
    DialogSet.set_dialog(user_char_id,pc.id, 1014)
    DialogSet.destroy_user_dialog(user_char_id,susi.id)
  end

  def self.end_for_user(user_char_id)
    flash = ""
    pc=Character.find_by_name("quest_1_friend")
    DialogSet.destroy_user_dialog(user_char_id,pc.id)
    user_char = Character.find_by_id(user_char_id)
    user_char.quests[0].characters.each do |c|
      c.destroy
    end
    flash << user_char.increase_exp(1000)
    flash << user_char.pick_up(Weapon.find_by_id(1))
    flash << user_char.pick_up(Item.find_by_id(1))
    Quest::Quest2.preload(user_char_id)
    return flash
  end

end