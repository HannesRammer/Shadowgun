class CreatePaths < ActiveRecord::Migration
  def self.up
    create_table :paths do |t|
      t.string :name
      t.timestamps
    end
    %w{druide hüter}.each  do |name|
      Path.create(:name=>name)
    end
  end
  
  def self.down
    drop_table :paths
  end
end
