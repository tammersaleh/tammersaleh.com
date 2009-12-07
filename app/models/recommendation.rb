class Recommendation < ActiveRecord::Base
  attr_accessible :quote, :short_quote, :who, :who_url, :where, :where_url, :position, :company, :company_url
  validates_presence_of :quote, :who, :where, :where_url
  validates_format_of :where_url,   :with => URL_REGEX, :allow_blank => true
  validates_format_of :company_url, :with => URL_REGEX, :allow_blank => true
  validates_format_of :who_url,     :with => URL_REGEX, :allow_blank => true

  def self.random 
    ids = connection.select_values("SELECT id FROM recommendations")
    find(ids[rand(ids.length)].to_i) unless ids.empty?
  end

  def short_quote
    attributes["short_quote"].blank? ? quote : super
  end

  def to_s
    "recommendation from #{who}"
  end
end
