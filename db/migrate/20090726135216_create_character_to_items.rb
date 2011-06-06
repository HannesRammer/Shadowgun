class CreateCharacterToItems < ActiveRecord::Migration
  def self.up
    create_table :character_to_items do |t|
       t.integer :character_id
      t.integer :item_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :character_to_items
  end
end
