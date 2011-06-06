class CreateQuestCharacters < ActiveRecord::Migration
  def self.up
    create_table :quest_characters do |t|
       t.integer :character_id
      t.integer :quest_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :quest_characters
  end
end
