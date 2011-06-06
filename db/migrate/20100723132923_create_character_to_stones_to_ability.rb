class CreateCharacterToStonesToAbility < ActiveRecord::Migration
  def self.up
    create_table :character_to_stones_to_ability do |t|
      t.integer :character_id
      t.integer :stone_id
      t.integer :set_id
      t.integer :ability_id
      t.boolean :active     
      t.integer :power #percent

      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_stones_to_ability
  end
end
