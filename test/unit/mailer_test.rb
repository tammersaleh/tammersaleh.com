require 'test_helper'

class MailerTest < ActionMailer::TestCase
  context "A new comment email" do
    setup do
      @comment = Factory(:comment, :submitter_url => "http://someplace.com")
      @email = Mailer.create_new_comment(@comment)
    end
    
    should "be addressed to tsaleh+comments@gmail.com" do
      assert_equal ["tsaleh+comments@gmail.com"], @email.to
    end
    
    should "be from 'Notifier <notifier@tammersaleh.com>'" do
      assert_equal ["notifier@tammersaleh.com"], @email.from
    end
    
    should "have the post name in the subject" do
      assert_match(/#{@comment.post}/, @email.subject)
    end

    should "contain the submitter_url" do
      assert_body_contains(/#{@comment.submitter_url}/)
    end

    should "contain the submitter_name" do
      assert_body_contains(/#{@comment.submitter_name}/)
    end

    should "contain the submitter_email" do
      assert_body_contains(/#{@comment.submitter_email}/)
    end

    should "contain the comment body" do
      assert_body_contains(/#{@comment.body}/)
    end

    should "contain a link to the comment" do
      assert_body_contains(%r{http://localhost/posts/#{@comment.post.to_param}/comments/#{@comment.to_param}})
    end
  end
  
  def assert_body_contains(str_or_regex)
    assert_match str_or_regex, @email.body
  end
end
