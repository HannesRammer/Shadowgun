class CreateCharToDigiStones < ActiveRecord::Migration
  def self.up
    create_table :char_to_digi_stones do |t|
      t.integer :character_id
      t.integer :digi_stone_id
      t.integer :percent
      t.boolean :in_use

      t.timestamps
    end
  end

  def self.down
    drop_table :char_to_digi_stones
  end
end
