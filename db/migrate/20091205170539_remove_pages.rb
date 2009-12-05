class RemovePages < ActiveRecord::Migration
  def self.up
    drop_table :pages
  end

  def self.down
    create_table "pages", :force => true do |t|
      t.string   "title"
      t.text     "body"
      t.boolean  "published"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
      t.text     "description"
    end

    add_index "pages", ["slug"], :name => "index_pages_on_slug"
  end
end
