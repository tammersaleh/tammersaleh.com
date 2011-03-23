require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase

  context "given a post" do
    setup { @post = Factory(:post) }
    
    context "on POST to /post/:id/comments" do
      setup do
      end

      should_not_change("the nubmer of comments for that post") { @post.comments(true).count }

      should "raise an unknown action error" do
        assert_raise(ActionController::UnknownAction) do
          post :create, 
               :post_id => @post.to_param, 
               :comment => {:body => "Boo", :submitter_name => "bob", :submitter_email => "none@none.com" } 
        end
      end
    end
  end

  context "given a comment" do
    setup { @comment = Factory(:comment) }

    should_deny_access_on "DELETE to /post/:id/comments/:id" do
      delete :destroy, :post_id => @comment.post.to_param, :id => @comment.to_param
    end

    as_a_logged_in_user do
      context "on DELETE to /post/:id/comments/:id" do
        setup { delete :destroy, :post_id => @comment.post.to_param, :id => @comment.to_param}
        should_change("the nubmer of comments for that post", :by => -1) { @comment.post.comments(true).count }
        should_set_the_flash_to /destroyed/i
        should_redirect_to("dashboard_posts_url") { dashboard_posts_url }
      end
    end
  end

end
