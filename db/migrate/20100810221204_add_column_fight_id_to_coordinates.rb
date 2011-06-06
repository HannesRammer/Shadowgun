class AddColumnFightIdToCoordinates < ActiveRecord::Migration
  def self.up
    add_column :coordinates, :current_fight_id, :integer
    add_column :coordinates, :fight_in, :integer
  end

  def self.down
    remove_column :coordinates, :current_fight_id
    remove_column :coordinates, :fight_in
  end
end
