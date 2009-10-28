class PostsController < ApplicationController
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

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to(edit_post_url(@post))
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to(edit_post_url(@post))
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Post was successfully removed.'
    redirect_to(posts_url)
  end
end
