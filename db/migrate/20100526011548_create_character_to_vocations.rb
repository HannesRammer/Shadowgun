class CreateCharacterToVocations < ActiveRecord::Migration
  def self.up
    create_table :character_to_vocations do |t|
      t.integer :character_id
      t.integer :vocation_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :character_to_vocations
  end
end
