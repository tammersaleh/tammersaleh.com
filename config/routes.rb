ActionController::Routing::Routes.draw do |map|
  map.login  "/login",  :controller => :user_sessions, :action => :new
  map.logout "/logout", :controller => :user_sessions, :action => :destroy

  map.resource  :user_session

  map.resources :posts, :collection => {:dashboard => :get} do |post|
    post.resources :comments
  end
  map.resources :pages
  map.resources :images
  map.resources :assets

  map.root :controller => "posts", :action => "index"
end
