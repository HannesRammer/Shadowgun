class CreateCharacterToPaths < ActiveRecord::Migration
  def self.up
    create_table :character_to_paths do |t|
      t.integer :character_id
      t.integer :path_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :character_to_paths
  end
end
