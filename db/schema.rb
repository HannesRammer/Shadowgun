# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100810221204) do

  create_table "abilities", :force => true do |t|
    t.string   "group"
    t.string   "name"
    t.string   "usage_type"
    t.integer  "level"
    t.integer  "timecost"
    t.integer  "mana_cost"
    t.string   "mana_cost_type"
    t.integer  "factor"
    t.string   "factor_type"
    t.integer  "duration_sec"
    t.string   "active_till"
    t.integer  "active_times"
    t.string   "activate"
    t.integer  "dmg"
    t.string   "target"
    t.integer  "repeat"
    t.string   "unique_use"
    t.string   "effect_color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.integer  "character_id"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["character_id"], :name => "index_accounts_on_character_id"
  add_index "accounts", ["email"], :name => "index_accounts_on_email"
  add_index "accounts", ["username"], :name => "index_accounts_on_username"

  create_table "area_maps", :force => true do |t|
    t.integer  "x_min"
    t.integer  "x_max"
    t.integer  "y_min"
    t.integer  "y_max"
    t.string   "field"
    t.string   "field_type"
    t.string   "name",         :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "content_type"
    t.string   "filename"
    t.binary   "binary_data"
  end

  create_table "armors", :force => true do |t|
    t.string   "name"
    t.float    "armor"
    t.float    "level"
    t.string   "armor_type"
    t.float    "worth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "armors", ["armor"], :name => "index_armors_on_armor"
  add_index "armors", ["armor_type"], :name => "index_armors_on_armor_type"
  add_index "armors", ["level"], :name => "index_armors_on_level"
  add_index "armors", ["name"], :name => "index_armors_on_name"
  add_index "armors", ["worth"], :name => "index_armors_on_worth"

  create_table "body_parts", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.float  "multi"
    t.float  "level"
    t.float  "version"
    t.float  "worth"
  end

  create_table "char_to_digi_devices", :force => true do |t|
    t.integer  "character_id"
    t.integer  "digi_device_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "char_to_digi_stones", :force => true do |t|
    t.integer  "character_id"
    t.integer  "digi_stone_id"
    t.integer  "percent"
    t.boolean  "in_use"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_active_abilities", :force => true do |t|
    t.integer  "ability_id"
    t.integer  "character_id"
    t.string   "usage_type"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.integer  "valid_times"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_armors", :force => true do |t|
    t.integer  "character_id"
    t.integer  "armor_id"
    t.boolean  "active",       :default => false
    t.string   "armor_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "character_to_armors", ["active"], :name => "index_character_to_armors_on_active"
  add_index "character_to_armors", ["armor_id"], :name => "index_character_to_armors_on_armor_id"
  add_index "character_to_armors", ["armor_type"], :name => "index_character_to_armors_on_armor_type"
  add_index "character_to_armors", ["character_id"], :name => "index_character_to_armors_on_character_id"

  create_table "character_to_body_parts", :force => true do |t|
    t.integer  "character_id"
    t.integer  "body_part_id"
    t.boolean  "active",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_current_fights", :force => true do |t|
    t.integer  "character_id"
    t.integer  "current_fight_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_items", :force => true do |t|
    t.integer  "character_id"
    t.integer  "item_id"
    t.boolean  "active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "character_to_items", ["active"], :name => "index_character_to_items_on_active"
  add_index "character_to_items", ["character_id"], :name => "index_character_to_items_on_character_id"
  add_index "character_to_items", ["item_id"], :name => "index_character_to_items_on_item_id"

  create_table "character_to_paths", :force => true do |t|
    t.integer  "character_id"
    t.integer  "path_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_races", :force => true do |t|
    t.integer  "character_id"
    t.integer  "race_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_stones_to_ability", :force => true do |t|
    t.integer  "character_id"
    t.integer  "stone_id"
    t.integer  "set_id"
    t.integer  "ability_id"
    t.boolean  "active"
    t.integer  "power"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_vocations", :force => true do |t|
    t.integer  "character_id"
    t.integer  "vocation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_to_weapons", :force => true do |t|
    t.integer  "character_id"
    t.integer  "weapon_id"
    t.boolean  "active",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "character_to_weapons", ["active"], :name => "index_character_to_weapons_on_active"
  add_index "character_to_weapons", ["character_id"], :name => "index_character_to_weapons_on_character_id"
  add_index "character_to_weapons", ["weapon_id"], :name => "index_character_to_weapons_on_weapon_id"

  create_table "characters", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.float    "max_ability_points",   :default => 25.0
    t.float    "mind",                 :default => 5.0
    t.float    "agility",              :default => 5.0
    t.float    "body",                 :default => 5.0
    t.float    "charisma",             :default => 5.0
    t.float    "psychic",              :default => 5.0
    t.float    "luck",                 :default => 10.0
    t.float    "current_life",         :default => 250.0
    t.float    "max_life",             :default => 250.0
    t.float    "current_mana",         :default => 250.0
    t.float    "max_mana",             :default => 250.0
    t.string   "char_type"
    t.integer  "account_id"
    t.float    "current_exp",          :default => 0.0
    t.float    "next_lev_exp",         :default => 2500.0
    t.float    "level",                :default => 1.0
    t.float    "chance_to_hit",        :default => 30.0
    t.float    "chance_of_max_damage", :default => 30.0
    t.float    "chance_magic",         :default => 30.0
    t.float    "win",                  :default => 0.0
    t.float    "lose",                 :default => 0.0
    t.float    "gold",                 :default => 10.0
    t.boolean  "visible",              :default => true
    t.integer  "quest_owner_id",       :default => 0
    t.integer  "active_quest_status",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["account_id"], :name => "index_characters_on_account_id"
  add_index "characters", ["active_quest_status"], :name => "index_characters_on_active_quest_status"
  add_index "characters", ["agility"], :name => "index_characters_on_agility"
  add_index "characters", ["body"], :name => "index_characters_on_body"
  add_index "characters", ["char_type"], :name => "index_characters_on_char_type"
  add_index "characters", ["charisma"], :name => "index_characters_on_charisma"
  add_index "characters", ["current_exp"], :name => "index_characters_on_current_exp"
  add_index "characters", ["current_life"], :name => "index_characters_on_current_life"
  add_index "characters", ["current_mana"], :name => "index_characters_on_current_mana"
  add_index "characters", ["gender"], :name => "index_characters_on_gender"
  add_index "characters", ["gold"], :name => "index_characters_on_gold"
  add_index "characters", ["level"], :name => "index_characters_on_level"
  add_index "characters", ["lose"], :name => "index_characters_on_lose"
  add_index "characters", ["luck"], :name => "index_characters_on_luck"
  add_index "characters", ["max_life"], :name => "index_characters_on_max_life"
  add_index "characters", ["max_mana"], :name => "index_characters_on_max_mana"
  add_index "characters", ["name"], :name => "index_characters_on_name"
  add_index "characters", ["next_lev_exp"], :name => "index_characters_on_next_lev_exp"
  add_index "characters", ["psychic"], :name => "index_characters_on_psychic"
  add_index "characters", ["quest_owner_id"], :name => "index_characters_on_quest_owner_id"
  add_index "characters", ["win"], :name => "index_characters_on_win"

  create_table "coordinates", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.string   "field",            :default => "1_2"
    t.integer  "character_id"
    t.boolean  "active",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_fight_id"
    t.integer  "fight_in"
  end

  add_index "coordinates", ["active"], :name => "index_coordinates_on_active"
  add_index "coordinates", ["character_id"], :name => "index_coordinates_on_character_id"
  add_index "coordinates", ["field"], :name => "index_coordinates_on_field"
  add_index "coordinates", ["x"], :name => "index_coordinates_on_x"
  add_index "coordinates", ["y"], :name => "index_coordinates_on_y"

  create_table "current_fights", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dialog_sets", :force => true do |t|
    t.integer  "set_id"
    t.integer  "pc_char_id"
    t.integer  "user_char_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dialogs", :force => true do |t|
    t.integer  "set_id"
    t.text     "text"
    t.string   "dialog_type"
    t.integer  "next_set_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digi_devices", :force => true do |t|
    t.string   "name"
    t.string   "device_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digi_stones", :force => true do |t|
    t.string   "name"
    t.string   "stone_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "finances", :force => true do |t|
    t.string   "reason"
    t.string   "name"
    t.float    "how_much"
    t.string   "spending_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_bonis", :force => true do |t|
    t.float    "mind",                 :default => 0.0
    t.float    "body",                 :default => 0.0
    t.float    "agility",              :default => 0.0
    t.float    "charisma",             :default => 0.0
    t.float    "psychic",              :default => 0.0
    t.float    "chance_to_hit",        :default => 0.0
    t.float    "chance_to_block",      :default => 0.0
    t.float    "chance_to_max_damage", :default => 0.0
    t.float    "fire_damage",          :default => 0.0
    t.float    "chance_magic",         :default => 0.0
    t.float    "ice_damage",           :default => 0.0
    t.float    "fire_resist",          :default => 0.0
    t.float    "ice_resist",           :default => 0.0
    t.float    "drain_life",           :default => 0.0
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.float    "level"
    t.text     "description"
    t.boolean  "active",      :default => true
    t.float    "worth",       :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["active"], :name => "index_items_on_active"
  add_index "items", ["level"], :name => "index_items_on_level"
  add_index "items", ["name"], :name => "index_items_on_name"
  add_index "items", ["worth"], :name => "index_items_on_worth"

  create_table "path_to_vocation_to_abilities", :force => true do |t|
    t.integer  "path_id"
    t.integer  "vocation_id"
    t.integer  "ability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "path_to_vocations", :force => true do |t|
    t.integer  "path_id"
    t.integer  "vocation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paths", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quest_characters", :force => true do |t|
    t.integer  "character_id"
    t.integer  "quest_id"
    t.boolean  "active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quests", :force => true do |t|
    t.float    "gold"
    t.float    "exp"
    t.integer  "quest_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_to_paths", :force => true do |t|
    t.integer  "race_id"
    t.integer  "path_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stones", :force => true do |t|
    t.string   "name"
    t.string   "special"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "userchar_to_quests", :force => true do |t|
    t.integer  "character_id"
    t.integer  "quest_id"
    t.integer  "quest_status"
    t.boolean  "active",       :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vocations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weapons", :force => true do |t|
    t.string   "name"
    t.float    "range"
    t.float    "damage"
    t.float    "level"
    t.string   "damage_type"
    t.float    "hit_time"
    t.float    "worth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weapons", ["damage"], :name => "index_weapons_on_damage"
  add_index "weapons", ["damage_type"], :name => "index_weapons_on_damage_type"
  add_index "weapons", ["hit_time"], :name => "index_weapons_on_hit_time"
  add_index "weapons", ["level"], :name => "index_weapons_on_level"
  add_index "weapons", ["name"], :name => "index_weapons_on_name"
  add_index "weapons", ["range"], :name => "index_weapons_on_range"
  add_index "weapons", ["worth"], :name => "index_weapons_on_worth"

end
