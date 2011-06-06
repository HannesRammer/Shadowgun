class CreateCharacterToBodyParts < ActiveRecord::Migration
  def self.up
    create_table :character_to_body_parts do |t|
      t.integer :character_id
      t.integer :body_part_id
      t.boolean :active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_body_parts
  end
end
