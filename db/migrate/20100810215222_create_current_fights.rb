class CreateCurrentFights < ActiveRecord::Migration
  def self.up
    create_table :current_fights do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :current_fights
  end
end
