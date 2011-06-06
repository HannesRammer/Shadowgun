class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.float :level
      t.text :description
      t.boolean :active, :default => true
      t.float :worth, :default => 0

      t.timestamps
    end

    i = Item.create(:name=>"Heiltrank",
                      :level=>1,
                      :description=>"Heilt 10 LP",
                      :worth=>10)
    i.item_bonis.create
  end

  def self.down
    drop_table :items
  end
end
