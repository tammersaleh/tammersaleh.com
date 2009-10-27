require 'test_helper'

class MailerTest < ActionMailer::TestCase
  %w(
    user_activation
    reset_password_request
  ).each do |email_type|
    context "A #{email_type.humanize} email" do
      setup do
        @user = Factory(:user, :email => 'recipient@email.com', :perishable_token => '0123456789')
        @email = Mailer.send("create_#{email_type}", @user)
      end

      should "be delivered to the user's email address" do
        assert_equal [@user.email], @email.to
      end

      should "contain the perishable token" do
        assert_match(/#{@user.perishable_token}/, @email.body)
      end
    end
  end
end
