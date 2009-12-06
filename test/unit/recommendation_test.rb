require 'test_helper'

class RecommendationTest < ActiveSupport::TestCase
  should_validate_presence_of :quote, :who, :where, :where_url

  %w(where_url company_url).each do |url|
    should_allow_values_for url, 
                            "http://google.com", 
                            "https://g_oo-gle.ca", 
                            "http://google.com/~some/path.asd"

    should_not_allow_values_for url, 
                                "ftp://google.com", 
                                "eat me", 
                                "http://google.com/%20you%20suck"
  end
end
