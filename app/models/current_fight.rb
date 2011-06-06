class CurrentFight < ActiveRecord::Base
  has_one :coordinates, :dependent => :destroy

  def self.new_fight(char1, char2)
    cf = CurrentFight.create
    coordinates = Coordinates.create
    coordinates.x = char1.coordinates.x
    coordinates.y = char1.coordinates.y
    coordinates.field = char1.coordinates.field
    coordinates.current_fight_id = cf.id
    coordinates.save

    CurrentFight.fight_connect(char1, cf)
    CurrentFight.fight_connect(char2, cf)

  end

  def join_fight(char)
    CurrentFight.fight_connect(char, self)
  end

  def leave_fight(char)
    if self.last_two_fighters?
      self.end_fight
    else
      CurrentFight.fight_disconnect(char, self)
    end
  end

  def end_fight
    cfc = Coordinates.find_all_by_fight_in(self.id)
    cfc.each do |char_coordinates|
      CurrentFight.fight_disconnect(char_coordinates.character, self)
    end
    self.destroy
  end

  def members
    Character.find_all_by_id(self.members_coordinates)
  end

  def members_coordinates
    Coordinates.find_all_by_current_fight_id(self.id)
  end

  def members_count
    members_coordinates.length
  end

  def last_two_fighters?
    self.members_count <= 2 ? true : false
  end

  private

  def self.fight_connect(char, fight)
    char.coordinates.active = false
    char.coordinates.fight_in = fight.id
    char.coordinates.save
    ctcf = CharacterToCurrentFight.find_by_character_id(char.id) || CharacterToCurrentFight.create(:character_id => char.id)
    ctcf.current_fight_id = fight.id
    ctcf.save
  end

  def self.fight_disconnect(char, fight)
    char.coordinates.active = true if char.char_type == "user"
    char.coordinates.fight_in = nil
    char.coordinates.save

    CharacterToCurrentFight.find_by_character_id_and_current_fight_id(char.id, fight.id).destroy
  end

end
