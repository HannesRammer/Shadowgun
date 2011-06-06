class CreateCoordinates < ActiveRecord::Migration
  def self.up
    create_table :coordinates do |t|
      t.column :x, :integer
      t.column :y, :integer
      t.column :field, :string , :default=> "1_2"

      t.column :character_id, :integer
      t.column :active, :boolean , :default=>true
      t.timestamps
    end


  end

  def self.down
    drop_table :coordinates
  end
end
