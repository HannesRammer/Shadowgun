module Quest::Quest3
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
    DialogSet.set_dialog(user_char_id, Character.find_by_name("THE ENHANCER").id, 3000)
  end

  #
  #initiated for each user
  def self.create_for_user(user_char_id)
    params = {"mj"=>{"name"=>"MJ THRILLER",
                     "char_type"=>"enemy",
                     "gold"=>999,
                     "quest_owner_id"=>user_char_id,
                     "active_quest_status"=>1},
              "mj_xyf" => {"x"=>425, "y" =>140, "field"=> "1_2"},
              "killer"=>{"name"=>"TP-MAN",
                         "char_type"=>"enemy",
                         "gold"=>999,
                         "quest_owner_id"=>user_char_id,
                         "active_quest_status"=>2},
              "killer_xyf"=>{"x"=>325, "y" =>140, "field"=> "1_2"},
              "quest"=>{"gold"=>800, "exp"=>323450, "title"=>"Release THE Dead 'THRILLER'", "quest_id"=> 3000}}
    q = Quest.find_by_quest_id(3000) || Quest.create(params["quest"])
    q.save
    e = nil
    %w{mj killer}.each do |e_name|
      e = Character.generate(params["#{e_name}"],params["#{e_name}_xyf"])
      e.items << Item.find_by_name("Heiliges Abführmittel")  if e_name == "mj"
      e.items << Item.find_by_name("Goldenes Klopapier") if e_name == "killer"
      q.characters << e
    end
    return q
  end

  def self.update_for_user(user_char_id)
    return false unless Quest.quest_clear_enemy_status(user_char_id, 3000)
    pc=Character.find_by_name("THE ENHANCER")
    DialogSet.set_dialog(user_char_id, pc.id, 3011)
  end

  def self.end_for_user(user_char_id)
    flash = ""
    pc=Character.find_by_name("THE ENHANCER")
    DialogSet.destroy_user_dialog(user_char_id, pc.id)
    user_char = Character.find_by_id(user_char_id)
    flash << user_char.increase_exp(323450)
    return flash
  end

end