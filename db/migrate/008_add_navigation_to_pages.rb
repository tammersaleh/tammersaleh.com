class AddNavigationToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :navigation, :boolean
    add_index :pages, :navigation
  end

  def self.down
    remove_index :pages, :column => :navigation
    remove_column :pages, :navigation
  end
end
