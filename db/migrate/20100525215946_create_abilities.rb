class CreateAbilities < ActiveRecord::Migration
  def self.up
    create_table :abilities do |t|
      t.string :group
      t.string :name
      t.string :usage_type
      t.integer :level
      t.integer :timecost
      t.integer :mana_cost
      t.string :mana_cost_type
      t.integer :factor
      t.string :factor_type
      t.integer :duration_sec
      t.string :active_till
      t.integer :active_times
      t.string :activate
      t.integer :dmg
      t.string :target
      t.integer :repeat
      t.string :unique_use
      t.string :effect_color
      t.timestamps
    end
  end
  
  def self.down
    drop_table :abilities
  end
end
