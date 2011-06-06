class CreateVocations < ActiveRecord::Migration
  def self.up
    create_table :vocations do |t|
      t.string :name
      t.timestamps
    end
    %w{nähren}.each  do |name|
      Vocation.create(:name=>name)
    end
  end
  
  def self.down
    drop_table :vocations
  end
end
