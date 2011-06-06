class AddColumnPictureToAreaMaps < ActiveRecord::Migration
  def self.up
      add_column :area_maps, :description, :string
      add_column :area_maps, :content_type, :string
      add_column :area_maps, :filename, :string
      add_column :area_maps, :binary_data, :binary

  end
  
  def self.down

  end
end
