class CreateCharToDigiDevices < ActiveRecord::Migration
  def self.up
    create_table :char_to_digi_devices do |t|
      t.integer :character_id
      t.integer :digi_device_id
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :char_to_digi_devices
  end
end
