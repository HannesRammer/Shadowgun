class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.column :username,      :string
      t.column :email,         :string
      t.column :character_id,  :integer
      t.column :password_hash, :string
      t.column :password_salt, :string
      t.timestamps
    end
  end
  
  def self.down
    drop_table :accounts
  end
end
