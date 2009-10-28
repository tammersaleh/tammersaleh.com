# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include HoptoadNotifier::Catcher

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  before_filter :require_user

private
 
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def require_user
    deny_access unless logged_in?
  end

  def require_no_user
    if logged_in?
      deny_access :redirect_to => root_url,
                  :flash       => "You must be logged out to access this page."
    end
  end

  def deny_access(opts = {})
    opts[:flash]       ||= "You must be logged in to access this page."
    opts[:redirect_to] ||= login_url

    store_location
    flash[:notice] = opts[:flash]
    redirect_to opts[:redirect_to]
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or(url)
    redirect_to(session[:return_to] || url)
    session[:return_to] = nil
  end

  def interpolation_options
    { :resource_name => resource.to_s }
  end

end
