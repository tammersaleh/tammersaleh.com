require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  as_a_visitor do
    context "on GET to /users/new" do
      setup { get :new }
      should_render_template :new
      should_not_set_the_flash

      should "render a new user form" do
        assert_select "form[action$=?][method=post]", users_path
      end
    end

    context "on POST to /users/create with good info" do
      setup do
        post :create, 
             :user => { :name                  => "Joe", 
                        :email                 => "none@nowhere.com",
                        :password              => "letmein",
                        :password_confirmation => "letmein" }
      end

      should_redirect_to("homepage") { root_url }
      should_set_the_flash_to /welcome/i
      should_not_have_errors_on :user
    end

    context "on POST to /users/create with bad info" do
      setup do
        post :create, :user => { }
      end
      should_render_template :new
      should_not_set_the_flash
    end
  end

  as_a_logged_in_user do
    context "on GET to /users/:id/edit" do
      setup { get :edit, :id => @logged_in_user.to_param }
      should_render_template :edit

      should "render a multipart edit user form" do
        assert_select "form[action$=?][method=post][enctype='multipart/form-data']", user_path(@logged_in_user) do
          assert_select "input[type=hidden][name=_method][value=put]"
        end
      end

      should "render photo upload field" do
        assert_select "form" do
          assert_select "input[type=file][name=?]",   "user[photo]"
        end
      end
    end

    context "on PUT to /users/:id" do
      setup { put :update, :id => @logged_in_user.to_param, :user => {:name => "New"} }
      should_redirect_to("user profile") { user_path(@logged_in_user) }
      should_set_the_flash_to /updated/i
      should_not_have_errors_on :user
    end

    context "on GET to /users/:id" do
      setup do
        get :show, :id => @logged_in_user.to_param
      end
      should_render_template :show
      should "render edit link" do
        assert_select "a[href$=?]", edit_user_path(assigns(:user))
      end
    end

    context "dealing with another user's account" do
      setup { @user = Factory(:user) }

      should_be_denied_on "get :edit, :id => @user.to_param"
      should_be_denied_on "put :update, :id => @user.to_param, :user => {:name => 'New'}"

      context "on GET to /users/:id" do
        setup { get :show, :id => @user.to_param }
        should_render_template :show
        should "not render edit link" do
          assert_select "a[href$=?]", edit_user_path(assigns(:user)), :count => 0
        end
      end
    end
  end
end

