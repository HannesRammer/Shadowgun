class CreatePathToVocation < ActiveRecord::Migration
  def self.up
    create_table :path_to_vocations do |t|
      t.integer :path_id
      t.integer :vocation_id
      t.timestamps
    end
    PathToVocation.create(:path_id=>Path.find_by_name('druide').id,:vocation_id=>Vocation.find_by_name('nähren').id )
    PathToVocation.create(:path_id=>Path.find_by_name('hüter').id,:vocation_id=>Vocation.find_by_name('nähren').id)

  end
  
  def self.down
    drop_table :path_to_vocations
  end
end
