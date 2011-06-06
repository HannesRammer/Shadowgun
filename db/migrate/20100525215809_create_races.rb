class CreateRaces < ActiveRecord::Migration
  def self.up
    create_table :races do |t|
      t.string :name
      t.timestamps
    end
    %w{human ork elv}.each  do |name|
      Race.create(:name=>name)
    end
  end
  
  def self.down
    drop_table :races
  end
end
