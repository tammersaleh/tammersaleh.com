require "authlogic/test_case"

class ActionController::TestCase
  setup :activate_authlogic

  def self.as_a_visitor(&blk)
    context "As a visitor" do
      setup { logout }
      merge_block(&blk)
    end
  end

  def self.as_a_logged_in_user(&blk)
    context "As a logged in user" do
      setup    { login(@logged_in_user = Factory(:user)) }
      teardown { logout }

      merge_block(&blk)
    end
  end

  def self.should_be_denied(opts = {})
    opts[:flash]    ||= /logged in/i
    opts[:redirect] ||= 'login_url'

    should_redirect_to(opts[:redirect]) { eval(opts[:redirect]) }
    should_set_the_flash_to opts[:flash]
  end

  def self.should_deny_access_on(name, opts = {}, &blk)
    context name do
      setup &blk
      should_be_denied opts
    end
  end

  def logout
    UserSession.find && UserSession.find.destroy 
  end

  def login(user)
    UserSession.create(user)
  end
end
