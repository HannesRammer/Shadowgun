class Quest < ActiveRecord::Base
  has_many :quest_characters,  :order=>"id asc", :dependent => :destroy
  has_many :characters, :through => :quest_characters

  include Quest1
  include Quest2
  include Quest3

  def self.destroy_char_normal?(d)
    if d.name == "TP-MAN"
      return false
    else
      return true
    end
  end

  def status_for_user_char(user_char_id)
    Quest.status_for_user_char(user_char_id, self.id)
  end

  def self.status_for_user_char(user_char_id, quest_id = nil)
    return nil unless !quest_id.blank?
    utq = UsercharToQuest.find_by_character_id_and_quest_id(user_char_id, quest_id)
    if !utq.nil?

      utq.quest_status
    else
      nil
    end

  end

  def self.set_status_for_user_char(quest_id, user_char_id, status)
    utq = UsercharToQuest.find_by_character_id_and_quest_id(user_char_id, quest_id)
    utq.quest_status = status
    if utq.save
      "quest status updated"
    else
      "ERROR Quest.set_status_for_user_char(#{quest_id},#{user_char_id},#{status})"
    end
  end

  def completed(user_char_id)
    eval "self.status_for_user_char(user_char_id) == Quest::Quest#{self.quest_id / 1000}.final_status ? true : false"
  end

  def self.last_enemy_for_this_status(user_char_id, quest_nr)
    status_ok = Quest.active_quest_enemies(user_char_id, quest_nr).length == 1 ? true : false
  end

  def self.quest_clear_enemy_status(user_char_id, quest_nr)
    status_ok = Quest.active_quest_enemies(user_char_id, quest_nr).blank? ? true : false
  end

  def next_enemy

  end

  def self.quest_enemies(user_char_id, quest_id)
    char=Character.find_by_id(user_char_id, :order=>"created_at asc")
    quest = char.quests[quest_id - 1]
    quest_char_ids = quest.quest_characters.collect{|c| c.character_id}
    Character.find_all_by_id(quest_char_ids).collect{|c| c if c.char_type == 'enemy' }
  end

  def self.active_quest_enemies(user_char_id, quest_nr)
    char=Character.find_by_id(user_char_id, :order=>"created_at asc")
    quest = char.quests[quest_nr/1000 - 1]
    quest_char_ids = quest.quest_characters.collect{|c| c.character_id}
    return chars = Character.find_all_by_id_and_active_quest_status_and_char_type(quest_char_ids, quest.status_for_user_char(user_char_id), 'enemy')
  end

  #real quest_id
  def self.number_from_id(db_quest_id)
    Quest.find_by_quest_id(db_quest_id).quest_id
  end
end
