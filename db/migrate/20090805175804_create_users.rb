class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name
      t.string  :email

      t.string  :crypted_password
      t.string  :password_salt

      t.string  :persistence_token 
      t.string  :perishable_token 
      t.boolean :active, :default => false, :null => false

      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      
      t.timestamps
    end

    add_index :users, :active
    add_index :users, :email
    add_index :users, :perishable_token
  end

  def self.down
    drop_table :users
  end
end
