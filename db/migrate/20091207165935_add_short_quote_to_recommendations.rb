class AddShortQuoteToRecommendations < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :short_quote, :string
  end

  def self.down
    remove_column :recommendations, :short_quote
  end
end
