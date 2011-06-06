class CreateUsercharToQuests < ActiveRecord::Migration
  def self.up
    create_table :userchar_to_quests do |t|
      t.integer :character_id
      t.integer :quest_id
      t.integer :quest_status
      t.boolean :active, :default => true
      
      t.timestamps
    end
  end

  def self.down
    drop_table :userchar_to_quests
  end
end
