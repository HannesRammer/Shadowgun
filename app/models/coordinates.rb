class Coordinates < ActiveRecord::Base
  belongs_to :character
  belongs_to :current_fight

  def self.valid_field_path(x, y)
    if x > 30 && x < 570 && y > 30 && y < 470
      true
    else
      false
    end
  end

  def self.find_new_field(x, y, field)
    fields = field.split("_")
    xfield = fields[0].to_i
    yfield = fields[1].to_i
    if x < 30
      x = 570
      xfield = xfield == 1 ? 3 : xfield -= 1
    elsif x > 570
      x = 30
      xfield = xfield == 3 ? 1 : xfield += 1
    elsif y < 30
      y = 470
      yfield = yfield == 1 ? 3 : yfield -= 1
    elsif y > 470
      y = 70
      yfield = yfield == 3 ? 1 : yfield += 1
    end
    return [x, y, "#{xfield}_#{yfield}"]
  end

  def self.find_others(char_id, f, x = nil, y = nil)
    if x && y && char_id
      range = 100
      x_min = x - range
      x_max = x + range
      y_min = y - range
      y_max = y + range
      #condition = "select * from coordinates where field = '#{c.field}'"
      #TODO change find by active=false to update where updated_at timestamp longer than 5 min ago
      inactive_condition = "select * from coordinates where field = '#{f}' and (x > #{x_min}) and (x < #{x_max}) and (y > #{y_min}) and (y < #{y_max}) and character_id != #{char_id} and active = false"
      Coordinates.find_by_sql(inactive_condition).each do |coordinates|
        if coordinates.updated_at < (Time.now - 5.minutes)
          coordinates.active = true
          coordinates.save
        end
      end
      active_condition = "select * from coordinates where field = '#{f}' and (x > #{x_min}) and (x < #{x_max}) and (y > #{y_min}) and (y < #{y_max}) and character_id != #{char_id} and active = true"
      active_coordinates = Coordinates.find_by_sql(active_condition)
    else
      active_condition = "select * from coordinates where field = '#{f}' and character_id != #{char_id} and active = true"
      active_coordinates = Coordinates.find_by_sql(active_condition)
    end

  end


  def self.new_coordinates(opts={})
    x = !opts["x"].blank? ? opts["x"] : (50 + rand(500))
    y = !opts["y"].blank? ? opts["y"] : (50 + rand(400))
    field = !opts["field"].blank? ? opts["field"] : "#{rand(3)+1}_#{rand(3)+1}"
    Coordinates.create(:x=>x, :y=>y, :field=>field)
  end

  def self.compass_for(character_id)
    user_char = Character.find_by_id(character_id)
    direction=[]
    next_goal = user_char.next_goal
    if next_goal
      ucf = user_char.coordinates.field
      ncf = next_goal.coordinates.field
      if ucf == ncf
        direction << if next_goal.coordinates.x > user_char.coordinates.x
          "ost"
        elsif next_goal.coordinates.x < user_char.coordinates.x
          "west"
        else
          ""
        end
        direction << if next_goal.coordinates.y > user_char.coordinates.y
          "süd"
        elsif next_goal.coordinates.y < user_char.coordinates.y
          "nord"
        else
          ""
        end
      else
        direction << if ncf.split("_")[0].to_i > ucf.split("_")[0].to_i
          "ost"
        elsif ncf.split("_")[0].to_i < ucf.split("_")[0].to_i
          "west"
        else
          ""
        end
        direction << if ncf.split("_")[1].to_i > ucf.split("_")[1].to_i
          "süd"
        elsif ncf.split("_")[1].to_i < ucf.split("_")[1].to_i
          "nord"
        else
          ""
        end
      end
      #direction.join(" and ")
    else
      []
    end
  end

  def self.fields
    Coordinates.map_fields + Coordinates.place("town") + Coordinates.place("room")
  end

  def self.place(town_room)
    AreaMap.find_all_by_field_type(town_room).collect { |x| "#{town_room}_#{x.id}" }
  end

  def self.map_fields
    ["1_1", "1_2", "1_3", "2_1", "2_2", "2_3", "3_1", "3_2", "3_3"]
  end

end
