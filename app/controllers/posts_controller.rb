class PostsController < InheritedResources::Base
  skip_before_filter :require_user, :only => [:index, :show]
  
  def index
    @posts = Post.ordered.show_unpublished(logged_in?)

    respond_to do |format|
      format.html 
      format.atom do
        @posts = @posts.limit(20)
        render :layout => false # uses index.atom.builder
      end
    end
  end

  def dashboard
    @unpublished_posts = Post.ordered.unpublished
    @recent_comments   = Comment.ordered.limit(20)
  end

  def create
    create! do |success, failure|
      success.html { redirect_to(edit_post_url(@post)) }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to(edit_post_url(@post)) }
    end
  end
end
