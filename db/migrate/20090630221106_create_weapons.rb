class CreateWeapons < ActiveRecord::Migration
  def self.up
    create_table :weapons do |t|
      t.string :name
      t.float :range
      t.float :damage
      t.float :level
      t.string :damage_type
      t.float :hit_time
      t.float :worth
      t.timestamps
    end

    array = [["schwert", 1.5, 20, 1, 4, 30, 'close'],
             ["doppelklingenschwert", 2.5, 30, 3, 4, 70, 'close'],
             ["Zulu-Schwert", 3.2, 40, 5, 5, 110, 'close'],
             ["bogen", 15, 10, 1, 3, 15, 'range'],
             ["Power-Bow", 30, 25, 3, 3, 150, 'range'],
             ["Langbogen", 40, 30, 5, 5, 100, 'range']]

    array.each do |a|
      w = Weapon.new
      w.name = a[0]
      w.range = a[1]
      w.damage = a[2]
      w.level = a[3]
      w.hit_time = a[4]
      w.worth = a[5]
      w.damage_type = a[6]
      w.save
      w.item_bonis.create
    end

  end

  def self.down
    drop_table :weapons
  end
end
