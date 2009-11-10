require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase
  as_a_visitor do
    should_deny_access_on("GET to /posts/new") { get :new }
    should_deny_access_on("GET to /dashboard") { get :dashboard }
    should_deny_access_on("POST to /posts")    { post :create }

    context "with posts and comments" do
      setup do
        Factory(:post)
        Factory(:comment)
      end

      context "on GET to /posts" do
        setup { get :index }

        should "have a link to the atom feed in the header" do
          assert_select 'html' do
            assert_select 'head' do
              assert_select 'link[type=?]', 'application/atom+xml' do
                assert_select '[href=?]', %r{http://feeds.feedburner.com/TammerSaleh}
              end
            end
          end
        end

        should_render_template :index
        should_assign_to :posts

        before_should "see the posts in order" do
          ordered = Post.ordered
          Post.expects(:ordered).at_least_once.returns(ordered)
        end

        before_should "only see published posts" do
          posts = Post.show_unpublished(nil)
          ActiveRecord::NamedScope::Scope.any_instance.expects(:show_unpublished).at_least_once.with(nil).returns(posts)
        end
      end

      context "on GET to /posts.atom" do
        setup do
          accept :atom
          get :index
        end

        should_assign_to(:posts)

        should "have ContentType set to 'application/atom+xml'" do
          assert_match %r{application/atom\+xml}, @response.content_type, "Body: #{@response.body.first(100)} ..."
        end

        should "return <feed/> as the root element" do
          body = @response.body.first(100).map {|l| "  #{l}"}
          assert_select 'feed', 1, "Body:\n#{body}...\nDoes not have <feed/> as the root element."
        end

        should "have a link back to http://feeds.feedburner.com/TammerSaleh" do
          assert_select 'link[rel=self]' do
            assert_select '[href=?]', 'http://feeds.feedburner.com/TammerSaleh'
          end
        end    
      end
    end
  end

  as_a_logged_in_user do
    context "with posts and comments" do
      setup do
        Factory(:post)
        Factory(:comment)
      end

      context "on GET to :dashboard" do
        setup { get :dashboard }
        should_render_template :dashboard
        should_not_set_the_flash
        should_assign_to :unpublished_posts
        should_assign_to :recent_comments
      end
    end

    context "on GET to /posts/new" do
      setup { get :new, :id => @post.to_param }
      should_render_template :new
      should_assign_to :post
    end

    context "on POST to /posts with good values" do
      setup { post :create, :post => {:title => "Post Title", :body => "Post Body", :extended => ""}}
      should_set_the_flash_to %r{created}i
      should_redirect_to("edit page for post") { edit_post_url(assigns(:post)) }
      should_create :post
    end

    context "on POST to /posts with bad values" do
      setup { post :create, :post => {}}
      should_not_set_the_flash
      should_render_template :new
      should_not_change("the number of posts"){Post.count}
    end
  end

  context "given a published post" do
    setup { @post = Factory(:post, :published => true) }

    as_a_visitor do
      should_deny_access_on("GET to /posts/:id/edit") { get :edit, :id => @post.to_param }
      should_deny_access_on("PUT to /posts/:id")      { put :update, :id => @post.to_param }
      should_deny_access_on("DELETE to /posts/:id")   { delete :destroy, :id => @post.to_param }

      context "on GET to /posts/:id" do
        setup { get :show, :id => @post.to_param }
        should_render_template :show
        should_assign_to :post
      end
    end

    as_a_logged_in_user do
      context "on GET to /posts/:id/edit" do
        setup { get :edit, :id => @post.to_param }
        should_render_template :edit
        should_assign_to :post
      end

      context "on PUT to /posts/:id with good values" do
        setup { put :update, :id => @post.to_param, :post => {:title => "New Title"}}
        should_set_the_flash_to %r{updated}i
        should_redirect_to("edit page for post") { edit_post_url(assigns(:post)) }
        should "update the post" do
          assert_equal "New Title", assigns(:post).title
        end
      end

      context "on PUT to /posts/:id with bad values" do
        setup { put :update, :id => @post.to_param, :post => {:title => ""}}
        should_not_set_the_flash
        should_render_template :edit
      end

      context "on DELETE to /posts/:id" do
        setup { delete :destroy, :id => @post.to_param }
        should_set_the_flash_to %r{removed}i
        should_redirect_to("posts listing") { posts_url }
        should_destroy :post
      end
    end
  end

end
