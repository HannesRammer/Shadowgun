class CreateCharacterToAbilities < ActiveRecord::Migration
  def self.up
    create_table(:character_to_abilities) do |t|
      t.column :character_id,    :integer
      t.column :ability_id, :integer
      t.column :value, :integer, :default => 0
    end
  end
  def self.down
    drop_table :character_to_abilities
  end
end
