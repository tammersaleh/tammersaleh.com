class AddSlugToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :slug, :string
    add_index :pages, :slug
  end

  def self.down
    remove_index :pages, :column => :slug
    remove_column :pages, :slug
  end
end
