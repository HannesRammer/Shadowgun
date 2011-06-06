class CreateCharacterToArmors < ActiveRecord::Migration
  def self.up
    create_table :character_to_armors do |t|
       t.integer :character_id
      t.integer :armor_id
      t.boolean :active, :default => false
      t.string :armor_type 
      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_armors
  end
end
