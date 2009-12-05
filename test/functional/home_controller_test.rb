require File.dirname(__FILE__) + '/../test_helper'

class HomeControllerTest < ActionController::TestCase
  as_a_visitor do
    context "on GET to /home" do
      setup { get :show }

      should_render_template :show
      should_assign_to :posts
      should_render_with_layout :home

      before_should "see the posts in order" do
        ordered = Post.ordered
        Post.expects(:ordered).at_least_once.returns(ordered)
      end
    end
  end
end
