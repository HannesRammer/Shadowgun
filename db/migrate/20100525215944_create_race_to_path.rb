class CreateRaceToPath < ActiveRecord::Migration
  def self.up
    create_table :race_to_paths do |t|
      t.integer :race_id
      t.integer :path_id
      t.timestamps
    end
    RaceToPath.create(:race_id=>Race.find_by_name('human').id, :path_id=>Path.find_by_name('druide').id)
    RaceToPath.create(:race_id=>Race.find_by_name('human').id, :path_id=>Path.find_by_name('hüter').id)
    RaceToPath.create(:race_id=>Race.find_by_name('ork').id, :path_id=>Path.find_by_name('druide').id)
    #RaceToPath.create(:race_id=>Race.find_by_name('ork').id, :path_id=>Path.find_by_name('hüter').id)
    #RaceToPath.create(:race_id=>Race.find_by_name('elv').id, :path_id=>Path.find_by_name('druide').id)
    RaceToPath.create(:race_id=>Race.find_by_name('elv').id, :path_id=>Path.find_by_name('hüter').id)

  end

  def self.down
    drop_table :race_to_paths
  end
end
