class CreateDialogs < ActiveRecord::Migration
  def self.up
    create_table :dialogs do |t|
      t.integer :set_id
      t.text :text
      t.string :dialog_type
      t.integer :next_set_id
      t.string :action

      t.timestamps
    end

    standard_dialog = [[2, "Hi, wie geht's?", "user", 3, ""],
                       [0, "Bis bald!", "user", -1, ""],
                       [-999, "Beehren Sie uns wieder.", "trader", nil, ""],
                       [1, "Arrrg Attackeeeee!!!!!!", "enemy", nil, ""],
                       [3, "Danke gut! und selbst?", "trader", nil, ""],
                       [3, "Danke mir gehts auch gut. Gibt's was neues?", "user", 4, ""],
                       [3, "Ach, könnt besser sein.", "user", 5, ""],
                       [3, "Das Leben ist hart.", "user", 6, ""],
                       [4, "Nein, leider nix.", "trader", nil, ""],
                       [5, "Ja, so ist das leben..", "trader", nil, ""],
                       [6, "Jaja, mit manchem hat es nicht geklappt wie ich es wollte, ich sag mir live is a bitch, weil's scheinbar so sein sollte!", "trader", nil, ""]]
    standard_dialog.each do |a|


      d = Dialog.create()
      d.set_id = a[0]
      d.text = a[1]
      d.dialog_type = a[2]
      d.next_set_id = a[3]
      d.action = a[4]
      d.save
    end

  end

  def self.down
    drop_table :dialogs
  end
end
