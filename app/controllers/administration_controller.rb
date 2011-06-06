class AdministrationController < ApplicationController
  before_filter :login_required
  #BACKEND START
  def start

  end

  def backend

    @field = params[:field] || "1_2"
    @characters_coordinates = Coordinates.find_all_by_field(@field)
    load_items
  end


  def add_item_to_character
    text = ""
    if params[:char_id].blank?
      text = "kein char"
    else
      id = params[:char_id]
      character = Character.find_by_id(id)
      if request.post?
        item_class = params[:item_class]
        item_id = params[:item_id]
        params[:numbers].to_i.times do
          special = nil
          eval "special = #{item_class}.find_by_id(item_id)"
          text = character.pick_up(special)
        end
      end
    end
    render :update do |page|
      page["notice"].replace_html text
    end
  end

  def add_enemy
    text = ""
    @field = params[:coordinates][:field] || "1_2"
    level = params[:character][:level].to_i || 1
    if request.post?
      if c = Character.create(params[:character])
        c.coordinates = Coordinates.new_coordinates(params[:coordinates])
        c.coordinates.field = @field
        c.coordinates.save
        c.random_attributes_for_level(level)
        (level - 1).times do
          c.lvl_up_increase_life
          c.next_lev_exp = (((c.max_life) + (c.max_life/10 * (c.level / 2)))* 10)
          c.save
        end
        c.current_life = c.max_life
        c.save

        w = Weapon.find_by_id(rand(Weapon.count) + 1)
        text = c.pick_up(w)
        c.use_item(CharacterToWeapon.find_by_character_id_and_weapon_id(c.id,w.id))

        a = Armor.find_by_id(rand(Armor.count) + 1)
        text += c.pick_up(a)
        c.use_item(CharacterToArmor.find_by_character_id_and_armor_id(c.id,a.id))
        

      end
      @characters_coordinates = Coordinates.find_all_by_field(@field)
      render :update do |page|
        page["notice"].replace_html "character erstellt #{text}"
        page["area_maps"].replace_html :partial=>"administration/enemy_map"
      end


    end

  end

  def save_enemy_map
    char = Character.find_by_id(params[:char_id])
    coordinates = char.coordinates
    coordinates.x = params[:x]
    coordinates.y = params[:y]
    coordinates.field = params[:field]
    coordinates.save
    render :nothing => true
  end

  def random_attributes_for_level(x)
    max = (25 + (x - 1))
    points_so_far = 0
    value = 0
    half_level = x/2
    quater_level = half_level / 2
    eigth_level = quater_level / 2
    %w{      mind agility body charisma     }.rand do |attribute|
      eval "value = #{rand(half_level)} #{['-', '+'].rand} #{eigth_level}"
      eval "self.#{attribute} = value"
      points_so_far += value
    end
    self.psychic = max - points_so_far
    self.save
  end

  def add_enemy_with_lvl(name, xyf = nil)
    e = Character.create(char)

    e.coordinates = Coordinates.new_coordinates(xyf)
    e
  end


  private

  def load_items
    weapons = Weapon.find(:all)
    armors = Armor.find(:all)
    items = Item.find(:all)
    @items = weapons + armors + items
  end


end
