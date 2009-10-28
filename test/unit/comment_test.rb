require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  should_belong_to :post
  should_validate_presence_of :submitter_name, :body, :post_id
  
  should_allow_values_for     :submitter_email, "tsaleh@gmail.com", "t-sa.l_eh+ext@none.ca"
  should_not_allow_values_for :submitter_email, "tsaleh", "t saleh@none.ca", "t,saleh@none"
                          
  should_allow_values_for :submitter_url, 
                          "http://google.com", 
                          "https://g_oo-gle.ca", 
                          "http://google.com/~some/path.asd"

  should_not_allow_values_for :submitter_url, 
                              "ftp://google.com", 
                              "eat me", 
                              "http://google.com/%20you%20suck"

  should "send mail on create" do
    Factory.create(:comment)
    assert_sent_email
  end

  should "return a gravatar url on #gravatar_url" do
    assert_match(%r{//gravatar.com/avatar}i, Factory(:comment).gravatar_url)
  end
end

