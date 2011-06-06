module Quest::Quest2
  def self.final_status
    6
  end

  #
  #initiated only once
  def self.first_time_initiate
    params = {"friend"=>{"name"=>"THE ENHANCER",
                         "char_type"=>"trader",
                         "gold"=>999999},
              "coordinates"=>{"x"=>210, "y"=>210, "field"=>"1_2"}}
    f = Character.find_by_name("THE ENHANCER") || Character.create(params["friend"])
    f.coordinates = Coordinates.new_coordinates(params["coordinates"])
    # user_chars = Character.user_chars
  end

  #
  #initiated for each user
  def self.preload(user_char_id)
    DialogSet.set_dialog(user_char_id, Character.find_by_name("THE ENHANCER").id, 2000)
  end

  #
  #initiated for each user
  def self.create_for_user(user_char_id)
    params = {"a1"=>{"name"=>"a1",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>1},
              "a2"=>{"name"=>"a2",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>1},
              "b1"=>{"name"=>"b1",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>2},
              "b2"=>{"name"=>"b2",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>2},
              "c1"=>{"name"=>"c1",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>3},
              "c2"=>{"name"=>"c2",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>3},
              "quest"=>{"gold"=>500, "exp"=>123450, "title"=>"Verstärkung", "quest_id"=> 2000}}
    q = Quest.find_by_quest_id(2000) || Quest.create(params["quest"])
    q.save
    e = nil
    xyf={"x"=>425, "y" =>140, "field"=> "1_2"}
    %w{a1 a2 b1 b2 c1 c2}.each do |e_name|
      eval "e = Character.generate(params['#{e_name}'],xyf)"
      q.characters << e
    end
    return q
  end

  def self.update_for_user(user_char_id)
    return false unless Quest.quest_clear_enemy_status(user_char_id, 2000)
    pc=Character.find_by_name("THE ENHANCER")
    DialogSet.set_dialog(user_char_id, pc.id, 2011)
  end

  def self.end_for_user(user_char_id)
    flash = ""
    pc=Character.find_by_name("THE ENHANCER")
    DialogSet.destroy_user_dialog(user_char_id, pc.id)
    user_char = Character.find_by_id(user_char_id)
    flash << user_char.increase_exp(123450)
    flash << user_char.pick_up(Weapon.find_by_id(1))
    flash << user_char.pick_up(Item.find_by_id(1))
    Quest::Quest3.preload(user_char_id)
    return flash
  end

end