class CreateItemBonis < ActiveRecord::Migration
  def self.up
    create_table :item_bonis do |t|
      t.float :mind , :default=>0
      t.float :body , :default=>0
      t.float :agility , :default=>0
      t.float :charisma  , :default=>0
      t.float :psychic , :default=>0
      t.float :chance_to_hit , :default=>0
      t.float :chance_to_block  , :default=>0
      t.float :chance_to_max_damage , :default=>0
      t.float :fire_damage     , :default=>0
      t.float :chance_magic     , :default=>0
      t.float :ice_damage       , :default=>0
      t.float :fire_resist     , :default=>0
      t.float :ice_resist     , :default=>0
      t.float :drain_life    , :default=>0
      t.integer :owner_id  
      t.string :owner_type

      t.timestamps
    end
  end

  def self.down
    drop_table :item_bonis
  end
end
