class CreateArmors < ActiveRecord::Migration
  def self.up
    create_table :armors do |t|
      t.string :name
      t.float :armor
      t.float :level
      t.string :armor_type
      t.float :worth
      t.timestamps
    end

    array = [["stirnband", 1, 1, "head", 5],
             ["mauerschild", 50, 50, "shield", 30000],
             ["lederrüstung", 4, 3, "body", 5, 5, 100]]

    array.each do |a|
      w = Armor.new
      w.name = a[0]
      w.armor = a[1]
      w.level = a[2]
      w.armor_type = a[3]
      w.worth= a[4]
      w.save
      w.item_bonis.create
    end


  end

  def self.down
    drop_table :armors
  end
end
