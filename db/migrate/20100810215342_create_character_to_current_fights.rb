class CreateCharacterToCurrentFights < ActiveRecord::Migration
  def self.up
    create_table :character_to_current_fights do |t|
      t.integer :character_id
      t.integer :current_fight_id
      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_current_fights
  end
end
