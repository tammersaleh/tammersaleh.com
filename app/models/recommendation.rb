class Recommendation < ActiveRecord::Base
  attr_accessible :quote, :who, :where, :where_url, :position, :company, :company_url
  validates_presence_of :quote, :who, :where, :where_url
end
