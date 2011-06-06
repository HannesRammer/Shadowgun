class CreateDigiStones < ActiveRecord::Migration
  def self.up
    create_table :digi_stones do |t|
      t.string :name
      t.string :stone_type

      t.timestamps
    end
  end

  def self.down
    drop_table :digi_stones
  end
end
