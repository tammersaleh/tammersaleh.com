require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
end

class ActionController::IntegrationTest
  def login_as(user)
    visit root_url
    fill_in "user_session_email",    :with => user.email
    fill_in "user_session_password", :with => user.password
    click_button "login"
  end

  def self.a_logged_in_user(&blk)
    context "A logged in user" do
      setup { login_as(@logged_in_user = Factory(:user)) }
      merge_block(&blk)
    end
  end

  def self.should_have_errors_on(xpath_subset)
    should "display errors on #{xpath_subset}" do
      assert_have_xpath ".//div[@class = 'fieldWithErrors']/#{xpath_subset}"
    end
  end
end

