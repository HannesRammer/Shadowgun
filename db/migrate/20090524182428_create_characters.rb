class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.column :name,    :string
      t.column :gender,    :string
      t.column :max_ability_points, :float, :default => 25
      t.column :mind,    :float, :default => 5
      t.column :agility,    :float, :default => 5
      t.column :body,    :float, :default => 5
      t.column :charisma,    :float, :default => 5
      t.column :psychic,    :float, :default => 5
      t.column :luck,    :float, :default => 10# percent
      t.column :current_life,    :float, :default => 250
      t.column :max_life,    :float, :default => 250
      t.column :current_mana,    :float, :default => 250
      t.column :max_mana,    :float, :default => 250
      t.column :char_type,    :string
      t.column :account_id,       :int
      t.column :current_exp,       :float, :default => 0
      t.column :next_lev_exp,       :float, :default => 2500
      t.column :level,       :float, :default => 1
      t.column :chance_to_hit,       :float, :default => 30
      t.column :chance_of_max_damage,       :float, :default => 30
      t.column :chance_magic,       :float, :default => 30
      t.column :win,       :float, :default => 0
      t.column :lose,       :float, :default => 0
      t.column :gold,       :float, :default => 10
      t.column :visible,       :boolean, :default => true
      t.column :quest_owner_id,       :int, :default => 0
      t.column :active_quest_status,       :int, :default => 0  #0= all

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
