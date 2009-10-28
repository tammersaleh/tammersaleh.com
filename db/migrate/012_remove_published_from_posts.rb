class RemovePublishedFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :published
  end

  def self.down
    add_column :posts, :published, :boolean, :default => false
    update("update posts set published = true where published_at is not null")
    add_index :posts, :published
  end
end
