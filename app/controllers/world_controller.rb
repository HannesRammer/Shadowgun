class WorldController < ApplicationController
  before_filter :login_required

  def index
    cf = @current_char.coordinates.field
    if cf.index("town") == 0 || cf.index("room") == 0
      set_user_visit_conditions(cf.split("_")[0], cf.split("_")[1])
    else
      set_user_view_conditions("load")
    end
    @areas = AreaMap.all
    #@areas = AreaMap.load_areas(@map)
  end


  def send_chat_data
    if params[:chat_input].strip.length > 1
      render :juggernaut => {:type => :send_to_channels, :channels => ["world"]} do |page|
        page.insert_html :top, 'chat_data', "#{@current_char.name}: #{h params[:chat_input]}<br/>"
      end
    end
    render :nothing => true
  end


  def move
    set_user_view_conditions("move")
    @current_char.regenerate_life
    #@areas = AreaMap.load_areas(@map) #if @field_is_new
    render :update do |page|
                     #page["map_script"].replace :partial => "world/map_script" #if @field_is_new
      page["navi"].replace_html :partial => "right_navi"
      page["map"].replace :partial => "world/map"
    end
  end

  def visit
    set_user_visit_conditions("town", params[:town]) if params[:town]
    set_user_visit_conditions("room", params[:room]) if params[:room]
    render :update do |page|
      page["navi"].replace_html :partial => "right_navi"
      page["map"].replace :partial => "world/map"
    end
  end

  def exit
    exit_place_id  = AreaMap.find_by_id(params[:exit_id]).field.split("_")[1]
    enter_place = AreaMap.find_by_id(exit_place_id)
    ccc = @current_char.coordinates
    ccc.field = enter_place.field
    ccc.x = enter_place.x_min
    ccc.y = enter_place.y_min
    ccc.save
    render :update do |page|
      page["map"].replace_html javascript_tag("window.location=window.location.href.split('?')[0]")
    end
  end

  def start_fight
    c1 = Character.find_by_id(params[:char_1])
    c2 = Character.find_by_id(params[:attacked_char])
    CurrentFight.new_fight(c1,c2)
    if c1.char_type == "user" && c1 == @current_char
      render :update do |page| #render :juggernaut => {:type => :send_to_channels, :channels => [c1.account_id.to_s]} do |page|

        @attacked_char = c2
        @fighters=[c2]
        @char=c1
        page["navi"].replace_html :partial =>"fight/action_bar"
        page["map"].replace :partial => "fight/map"
      end
    end
    if c2.char_type == "user" && c2 == @current_char
      render :update do |page| #render :juggernaut => {:type => :send_to_channels, :channels => ["#{c2.account_id}"]} do |page|
        @attacked_char = c1
        @fighters=[c1]
        @char=c2
        page["navi"].replace_html :partial =>"fight/action_bar"
        page["map"].replace :partial => "fight/map"
      end
    end
    #render :nothing => true
  end

  private

  def set_user_view_conditions(way)
    c = @current_char.coordinates
    values = @current_char.allowed_move_char(params[:x].to_i, params[:y].to_i, c, way)

    @x = values[0]
    @y = values[1]
    @field = values[2]


    #@field_is_new = values[3]  inactive
    @map = @field
    @other_coordinates = Coordinates.find_others(@current_char.id, c.field, @x, @y)

  end


  def set_user_visit_conditions(way, town_room_id)
    c = @current_char.coordinates
    values = @current_char.allowed_move_char(params[:x].to_i, params[:y].to_i, c, way, town_room_id)
    @x = values[0]
    @y = values[1]
    @field = values[2]
    if @field.include?('town') || @field.include?('room')
      @town_room_id = @field.split('_')[1] #AreaMap.find_by_id(@field.split('_')[1]).id
    end
    #@field_is_new = values[3]  inactive
    @map = @field


    eval "@#{way} = AreaMap.find_by_id(#{town_room_id})"
    @other_coordinates = Coordinates.find_others(@current_char.id, "#{way}_#{town_room_id}")

  end
end
