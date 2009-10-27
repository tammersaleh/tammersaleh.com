class Mailer < ActionMailer::Base
  default_url_options[:host] = HOST

  def user_activation(user)
    @subject     = I18n.t 'actionmailer.create_confirmation', :default => 'Create confirmation'
    @from        = "none@example.com"
    @recipients  = user.email
    @body[:user] = user
    @body[:user_activation] = UserActivation.new(:user => user)
  end

  def reset_password_request(user)
    @subject     = I18n.t 'actionmailer.reset_password', :default => 'Reset password'
    @from        = "none@example.com"
    @recipients  = user.email
    @body[:user] = user
  end
end

