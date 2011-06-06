class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :accounts, :username
    add_index :accounts, :email
    add_index :accounts, :character_id
    add_index :characters, :name
    add_index :characters, :gender
    add_index :characters, :agility
    add_index :characters, :body
    add_index :characters, :charisma
    add_index :characters, :psychic
    add_index :characters, :luck
    add_index :characters, :current_life
    add_index :characters, :max_life
    add_index :characters, :current_mana
    add_index :characters, :max_mana
    add_index :characters, :char_type
    add_index :characters, :account_id
    add_index :characters, :current_exp
    add_index :characters, :next_lev_exp
    add_index :characters, :level
    add_index :characters, :win
    add_index :characters, :lose
    add_index :characters, :gold
    add_index :characters, :quest_owner_id
    add_index :characters, :active_quest_status
    add_index :coordinates, :x
    add_index :coordinates, :y
    add_index :coordinates, :field
    add_index :coordinates, :character_id
    add_index :coordinates, :active
    add_index :weapons, :name
    add_index :weapons, :range
    add_index :weapons, :damage
    add_index :weapons, :level
    add_index :weapons, :damage_type
    add_index :weapons, :hit_time
    add_index :weapons, :worth
    add_index :character_to_weapons, :character_id
    add_index :character_to_weapons, :weapon_id
    add_index :character_to_weapons, :active
    add_index :armors, :name
    add_index :armors, :armor
    add_index :armors, :level
    add_index :armors, :armor_type
    add_index :armors, :worth
    add_index :character_to_armors, :character_id
    add_index :character_to_armors, :armor_id
    add_index :character_to_armors, :active
    add_index :character_to_armors, :armor_type
    add_index :items, :name
    add_index :items, :level
    #add_index :items, :description
    add_index :items, :active
    add_index :items, :worth
    add_index :character_to_items, :character_id
    add_index :character_to_items, :item_id
    add_index :character_to_items, :active
  end

  def self.down

    
  end

end
