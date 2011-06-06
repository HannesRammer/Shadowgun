class CreateSubCultures < ActiveRecord::Migration
  def self.up
    create_table :sub_cultures do |t|
      t.column :name,    :string
      t.timestamps
    end

    names =["Anubier", "Apokalyptiker", "Bleicher",
            "Chronisten",
            "Geißler",
            "Hellvetiker",
            "Jehammedaner",
            "Neolibyer",
            "Richter",
            "Schrotter",
            "Sipplinge",
            "Spitalier",
            "Wiedertäufe"]

    names.each do |name|
      s = SubCulture.new()
      s.name = name
      s.save
    end





  end

  def self.down
    drop_table :sub_cultures
  end
end
