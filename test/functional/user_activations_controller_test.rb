require 'test_helper'

class UserActivationsControllerTest < ActionController::TestCase
  context "given a user activation" do
    setup { @user_activation = UserActivation.new(:user => Factory(:inactive_user)) }

    as_a_visitor do
      context "on GET to /user_activations/token" do
        setup { get :show, :id => @user_activation.to_param }

        should_render_template :show
        should_not_set_the_flash

        should "render an edit user_activation form" do
          assert_select "form[action$=?][method=post]", user_activation_path(@user_activation)
        end

        should "render name field" do
          assert_select "form" do
            assert_select "input[type=text][name=?]", "user_activation[user][name]"
          end
        end

        should "render password fields" do
          assert_select "form" do
            assert_select "input[type=password][name=?]", "user_activation[user][password]"
            assert_select "input[type=password][name=?]", "user_activation[user][password_confirmation]"
          end
        end
      end

      context "on GET to /user_activations/show with bad token" do
        setup { get :show, :id => "invalid" }

        should_redirect_to("signup url") { signup_url }
        should_set_the_flash_to /invalid/i
      end

      context "on POST to /user_activations/token with good info" do
        setup do
          post :update, 
               :id => @user_activation.to_param,
               :user_activation => {
                 :user => { :name                  => "Joe", 
                            :password              => "letmein",
                            :password_confirmation => "letmein" } }
        end

        should_redirect_to("homepage") { root_url }
        should_set_the_flash_to /welcome/i
        should_not_have_errors_on :user_activation
      end

      context "on POST to /user_activations/token with bad info" do
        setup do
          post :update, :id => @user_activation.to_param, :user_activation => {:user => {}}
        end
        should_render_template :show
        should_not_set_the_flash
        should "display the errors" do
          assert_have_selector "#user_activation_user_name_input.error"
          assert_have_selector "#user_activation_user_password_input.error"
        end
      end
    end
  end
end

