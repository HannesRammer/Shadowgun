module WorldHelper

  def start_distance(other_char, current_char)
    x1 = (other_char.active_weapon && other_char.active_weapon.range || 2)
    x2 = (current_char.active_weapon && current_char.active_weapon.range || 2)
    if x1 >= x2
      return x1
    else
      return x2
    end

  end
  #in_fight_range at start
  def range?
    distance = (@attacked_char.active_weapon && @attacked_char.active_weapon.range || 2) - (@char.active_weapon && @char.active_weapon.range || 2)
    if distance < 0
      return 0
    else
      distance.to_i
    end

  end

  def enemy_range?(a, d)
    distance = (d.active_weapon && d.active_weapon.range || 2) - (a.active_weapon && a.active_weapon.range || 2)
    if distance < 0
      return 0
    else
      distance.to_i
    end

  end

end
