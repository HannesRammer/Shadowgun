class CreateCharacterToRaces < ActiveRecord::Migration
  def self.up
    create_table :character_to_races do |t|
      t.integer :character_id
      t.integer :race_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :character_to_races
  end
end
