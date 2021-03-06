class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :password_hash
      t.string :password_salt
      t.string :mail
      t.string :website
      t.integer :status
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
