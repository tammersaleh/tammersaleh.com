ActionController::Routing::Routes.draw do |map|
  map.login  "/login",  :controller => :user_sessions, :action => :new
  map.logout "/logout", :controller => :user_sessions, :action => :destroy

  map.resource  :user_session
  map.resources :pages, :only => [:show]

  map.root :controller => "pages", :action => "show", :id => "home"
end
