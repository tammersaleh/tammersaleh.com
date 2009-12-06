class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.text   :quote
      t.string :who
      t.string :where
      t.string :where_url
      t.string :position
      t.string :company
      t.string :company_url

      t.timestamps
    end
  end

  def self.down
    drop_table :recommendations
  end
end
