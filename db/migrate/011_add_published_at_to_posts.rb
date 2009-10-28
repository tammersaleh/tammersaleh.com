class AddPublishedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published_at, :timestamp
    update("update posts set published_at = created_at")
    add_index :posts, :published_at
  end

  def self.down
    remove_column :posts, :published_at
  end
end
