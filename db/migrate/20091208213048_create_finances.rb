class CreateFinances < ActiveRecord::Migration
  def self.up
    create_table :finances do |t|
      t.string :reason
      t.string :name
      t.float :how_much
      t.string :spending_type

      t.timestamps
    end
  end

  def self.down
    drop_table :finances
  end
end
