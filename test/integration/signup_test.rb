require 'test_helper'

class SignupTest < ActionController::IntegrationTest
  context "Signing up" do
    setup do 
      ActionMailer::Base.deliveries.clear
      visit "/signup"
      fill_in "user_email", :with => "none@example.com"
      click_button "Sign Up!"
    end

    should "not be signed in" do
      assert_nil UserSession.find
    end

    should "create an inactive user" do
      assert user = User.find_by_email("none@example.com")
      assert !user.active?
    end

    context "then following the activation link in the email" do
      setup do
        email_body = ActionMailer::Base.deliveries.first.body
        activation_link = email_body[%r{http://[a-z0-9._-]*(/[0-9a-zA-Z_/-]*)}, 1]
        activation_token = activation_link.split('/').last
        assert User.find_by_perishable_token(activation_token)
        visit activation_link
      end

      context "then filling in the activation form" do
        setup do
          fill_in "name", :with => "Joe Public"
          fill_in "password", :with => "s3kret"
          fill_in "password confirmation", :with => "s3kret"
          click_button "Sign up!"
        end

        should "create an activated user" do
          assert user = User.find_by_email("none@example.com")
          assert user.active?
        end

        should "be signed in" do
          assert UserSession.find
          assert_equal User.find_by_email("none@example.com").id, UserSession.find.user.id
        end
      end
    end
  end
end

