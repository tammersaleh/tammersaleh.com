class AddDescriptionToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :description, :text
  end

  def self.down
    remove_column :pages, :description
  end
end
