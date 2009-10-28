class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
