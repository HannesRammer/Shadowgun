class CreateCharacterToWeapons < ActiveRecord::Migration
  def self.up
    create_table :character_to_weapons do |t|
      t.integer :character_id
      t.integer :weapon_id
      t.boolean :active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_weapons
  end
end
