require 'test_helper'

class RecommendationTest < ActiveSupport::TestCase
  should_validate_presence_of :quote, :who, :where, :where_url

  %w(where_url company_url who_url).each do |url|
    should_allow_values_for url, 
                            "http://google.com", 
                            "https://g_oo-gle.ca", 
                            "http://google.com/~some/path.asd"

    should_not_allow_values_for url, 
                                "ftp://google.com", 
                                "eat me", 
                                "http://google.com/%20you%20suck"
  end

  should "return a human value on to_s" do
    assert_equal "recommendation from Bob", Factory(:recommendation, :who => "Bob").to_s
  end

  should "return the quote on short_quote if the short_quote is blank" do
    assert_equal "quote", Factory(:recommendation, :quote => "quote", :short_quote => "").short_quote
  end

  should "return the short_quote if the short_quote is not blank" do
    assert_equal "short", Factory(:recommendation, :short_quote => "short").short_quote
  end

  context "when there are recommendations" do
    setup do
      @one = Factory(:recommendation)
      @two = Factory(:recommendation)
    end

    context ".random" do
      should "return a recommendation" do
        assert_equal "Recommendation", Recommendation.random.class.name
      end

      should "be somewhat evenly distributed" do
        recommendations = (1..15).map { Recommendation.random }
        assert_contains recommendations, @one
        assert_contains recommendations, @two
      end
    end
  end
end
