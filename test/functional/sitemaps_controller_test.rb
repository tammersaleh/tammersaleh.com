require File.dirname(__FILE__) + '/../test_helper'

class SitemapsControllerTest < ActionController::TestCase
  as_a_visitor do
    context "when there are posts" do
      setup do
        Factory(:post, :published => true)
        Factory(:post, :published => true)
      end

      context "on get to show" do
        setup { get :show, :format => "xml" }
        should_render_template :show
        should_assign_to :posts
        should_assign_to :pages
      end
    end
  end
end
