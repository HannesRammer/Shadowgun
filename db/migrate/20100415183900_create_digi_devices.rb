class CreateDigiDevices < ActiveRecord::Migration
  def self.up
    create_table :digi_devices do |t|
      t.string :name
      t.string :device_type

      t.timestamps
    end
  end

  def self.down
    drop_table :digi_devices
  end
end
