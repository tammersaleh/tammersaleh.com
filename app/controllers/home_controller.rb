class HomeController < ApplicationController
  skip_before_filter :require_user, :only => [:show]

  def show
    @posts = Post.ordered.show_unpublished(logged_in?).to(3)
  end
end
