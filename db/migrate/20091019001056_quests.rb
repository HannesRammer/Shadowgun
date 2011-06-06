class Quests < ActiveRecord::Migration
  def self.up
    create_table :quests do |t|
      t.float :gold
      t.float :exp
      t.integer :quest_id
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :quests
  end
end
