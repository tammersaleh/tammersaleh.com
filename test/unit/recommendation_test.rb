require 'test_helper'

class RecommendationTest < ActiveSupport::TestCase
  should_validate_presence_of :quote, :who, :where, :where_url
end
