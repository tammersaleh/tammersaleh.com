class AddSourceUrlToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :source_url, :string
  end

  def self.down
    remove_column :images, :source_url
  end
end
