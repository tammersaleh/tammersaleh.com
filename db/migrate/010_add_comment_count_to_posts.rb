class AddCommentCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :comments_count, :integer, :default => 0, :null => false
    execute("UPDATE posts SET comments_count = (SELECT COUNT(id) FROM comments WHERE comments.post_id = posts.id)")
  end

  def self.down
    remove_column :posts, :comments_count
  end
end
