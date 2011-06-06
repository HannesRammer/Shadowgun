class CreateDialogSets < ActiveRecord::Migration
  def self.up
    create_table :dialog_sets do |t|
      t.integer :set_id
      t.integer :pc_char_id
      t.integer :user_char_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dialog_sets
  end
end
