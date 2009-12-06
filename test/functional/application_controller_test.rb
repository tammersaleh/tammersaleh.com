require 'test_helper'

class FooController < ApplicationController
  skip_before_filter :require_user, :only => :unprotected_foo

  def foo
    render :text => 'Success', :layout => "application"
  end

  def unprotected_foo
    render :text => 'Success', :layout => "application"
  end
end

class ApplicationControllerTest < ActionController::TestCase
  tests FooController

  setup do
    ActionController::Routing::Routes.add_named_route :foo, '/foo', 
                                                      :controller => 'foo', 
                                                      :action => 'foo'
    ActionController::Routing::Routes.add_named_route :unprotected_foo, 
                                                      '/unprotected_foo', 
                                                      :controller => 'foo', 
                                                      :action => 'unprotected_foo'
  end

  as_a_visitor do
    context "getting a protected page" do
      setup { get :foo }

      should_redirect_to("the login page") { login_url }
      should_set_the_flash_to /must be logged in/i
    end

    context "getting a public page" do
      setup { get :unprotected_foo }
      should "not present a logout link" do
        assert_no_match(/logout/, @response.body)
      end
    end
  end

  as_a_logged_in_user do
    context "the layout" do
      setup { get :foo }
      should "present the user with a logout link" do
        assert_select 'a[href=?]', logout_url, "Logout"
      end
    end
  end
end
