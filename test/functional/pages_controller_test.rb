require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase
  as_a_visitor do
    should_deny_access_on("GET to /pages/new") { get :new }
    should_deny_access_on("POST to /pages")    { post :create }

    context "on GET to /pages" do
      setup { get :index }

      should_render_template :index
      should_assign_to :pages

      before_should "see the pages in order" do
        ordered = Page.ordered
        Page.expects(:ordered).at_least_once.returns(ordered)
      end

      before_should "only see published pages" do
        pages = Page.show_unpublished(nil)
        ActiveRecord::NamedScope::Scope.any_instance.expects(:show_unpublished).at_least_once.with(nil).returns(pages)
      end
    end
  end

  as_a_logged_in_user do
    context "on GET to /pages/new" do
      setup { get :new, :id => @page.to_param }
      should_render_template :new
      should_assign_to :page
    end

    context "on POST to /pages with good values" do
      setup { post :create, :page => {:title => "Page Title", :body => "Page Body"}}
      should_set_the_flash_to %r{created}i
      should_redirect_to("page_url(assigns(:page))") { page_url(assigns(:page)) }
      should_create :page
    end

    context "on POST to /pages with bad values" do
      setup { post :create, :page => {}}
      should_not_set_the_flash
      should_render_template :new
      should_not_change("the nubmer of pages") { Page.count }
    end
  end

  context "given a published page" do
    setup { @page = Factory(:page, :published => true) }

    as_a_visitor do
      should_deny_access_on("GET to /pages/:id/edit") { get :edit, :id => @page.to_param }
      should_deny_access_on("PUT to /pages/:id")      { put :update, :id => @page.to_param }
      should_deny_access_on("DELETE to /pages/:id")   { delete :destroy, :id => @page.to_param }

      context "on GET to /pages/:id" do
        setup { get :show, :id => @page.to_param }
        should_render_template :show
        should_assign_to :page
      end
    end

    as_a_logged_in_user do
      context "on GET to /pages/:id/edit" do
        setup { get :edit, :id => @page.to_param }
        should_render_template :edit
        should_assign_to :page
      end

      context "on PUT to /pages/:id with good values" do
        setup { put :update, :id => @page.to_param, :page => {:title => "New Title"}}
        should_set_the_flash_to %r{updated}i
        should_redirect_to("page_url(assigns(:page))") { page_url(assigns(:page)) }
        should "update the page" do
          assert_equal "New Title", assigns(:page).title
        end
      end

      context "on PUT to /pages/:id with bad values" do
        setup { put :update, :id => @page.to_param, :page => {:title => ""}}
        should_not_set_the_flash
        should_render_template :edit
      end

      context "on DELETE to /pages/:id" do
        setup { delete :destroy, :id => @page.to_param }
        should_set_the_flash_to %r{removed}i
        should_redirect_to("pages_url") { pages_url }
        should_destroy :page
      end
    end
  end
end
