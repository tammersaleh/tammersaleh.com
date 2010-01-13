class SitemapsController < ApplicationController
  skip_before_filter :require_user

  def show
    @pages = [
      { :title => "Hire me.",  :url => "/hire"     },
      { :title => "About me.", :url => "/about"    },
      { :title => "Speaking.", :url => "/speaking" },
    ]
    @posts = Post.ordered.show_unpublished(false).all(:select => 'id, slug, title, created_at')
  end
end

