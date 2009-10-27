require 'test_helper'

class UserActivationTest < ActiveSupport::TestCase
  setup { Authlogic::Session::Base.controller = Authlogic::TestCase::MockController.new }

  context "given an inactive user" do
    setup { @user = Factory(:inactive_user) }

    context "a user activation created from user record" do
      setup { @user_activation = UserActivation.new(:user => @user) }

      should "be valid" do
        assert_valid @user_activation
      end

      should "return the user's perishable token for an id" do
        assert_not_nil @user.perishable_token
        assert_equal @user.perishable_token, @user_activation.id
      end

      should "return the user's perishable token for an to_param" do
        assert_not_nil @user.perishable_token
        assert_equal @user.perishable_token, @user_activation.to_param
      end
    end

    context "a user activation created via find with good token" do
      setup { @user_activation = UserActivation.find(@user.perishable_token) }

      should "return the user's perishable token for an to_param" do
        assert_not_nil @user.perishable_token
        assert_equal @user.perishable_token, @user_activation.to_param
      end
    end

    context "a user activation created via find with bad token" do
      setup { @user_activation = UserActivation.find("invalid") }

      should "be invalid" do
        assert !@user_activation.valid?
      end
    end

    context "a user activation created via find with nil token" do
      setup do
        User.update_all("perishable_token = null where id = #{@user.id}")
        @user_activation = UserActivation.find(nil)
      end

      should "be invalid" do
        assert !@user_activation.valid?
      end
    end

    context "when modifying the underlying user" do
      setup do
        @user_activation = UserActivation.new(:user => @user)
        params = {:user => {:name => "bob", :password => "s3kret", :password_confirmation => "s3kret"}}
        @ret = @user_activation.update_attributes(params)
      end

      should "return truish" do
        assert @ret
      end

      should "modify and save the user" do
        user = @user_activation.user
        user.reload
        assert_equal "bob", @user.name
      end

      should "activate the user" do
        assert @user_activation.user.reload.active?
      end

      should "log the user in" do
        assert UserSession.find
        assert_equal @user_activation.user.id, UserSession.find.user.id
      end
    end

    context "when modifying the underlying user with bad values" do
      setup do
        @user_activation = UserActivation.new(:user => @user)
        params = {:user => {}}
        @ret = @user_activation.update_attributes(params)
      end

      should "return falsish" do
        assert !@ret
      end

      should "not save the user" do
        user = @user_activation.user
        user.reload
        assert_not_equal "bob", @user.name
      end

      should "be invalid" do
        assert !@user_activation.valid?
        assert @user_activation.errors.on(:name).present?
        assert @user_activation.errors.on(:password).present?
      end

      should "delegate the errors to the user" do
        assert !@user_activation.user.errors.empty?
        assert_equal @user_activation.user.errors, @user_activation.errors
      end
    end
  end
end
