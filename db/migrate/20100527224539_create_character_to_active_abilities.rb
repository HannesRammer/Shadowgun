class CreateCharacterToActiveAbilities < ActiveRecord::Migration
  def self.up
    create_table :character_to_active_abilities do |t|
      t.integer :ability_id
      t.integer :character_id
      t.string :usage_type
      t.timestamp :valid_from
      t.timestamp :valid_till
      t.integer :valid_times
      t.timestamps
    end
  end
  
  def self.down
    drop_table :character_to_active_abilities
  end
end
