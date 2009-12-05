ActionController::Routing::Routes.draw do |map|
  map.login  "/login",  :controller => :user_sessions, :action => :new
  map.logout "/logout", :controller => :user_sessions, :action => :destroy

  map.about    "/about",    :controller => :pages, :action => :show, :id => "about"
  map.hire     "/hire",     :controller => :pages, :action => :show, :id => "hire"
  map.speaking "/speaking", :controller => :pages, :action => :show, :id => "speaking"

  map.resource :user_session
  map.resource :home, :controller => "home"

  map.resources :posts, :collection => {:dashboard => :get} do |post|
    post.resources :comments
  end
  map.resources :pages, :only => :show
  map.resources :images
  map.resources :assets

  map.root :controller => "home", :action => "show"
end
