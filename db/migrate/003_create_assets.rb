class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :asset_file_name
      t.string :asset_content_type
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
