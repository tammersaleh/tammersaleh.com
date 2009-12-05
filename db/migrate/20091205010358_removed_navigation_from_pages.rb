class RemovedNavigationFromPages < ActiveRecord::Migration
  def self.up
    remove_column :pages, :navigation
  end

  def self.down
    add_column :pages, :navigation, :boolean
  end
end
