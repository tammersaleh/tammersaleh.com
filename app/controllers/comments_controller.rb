class CommentsController < ApplicationController
  before_filter :grab_post
  skip_before_filter :require_user, :only => [:create]

  def create
    @comment = @post.comments.new(params[:comment])

    if verify_recaptcha(@comment) and @comment.save
      flash[:notice] = "Thanks for commenting, #{@comment.submitter_name}."
      redirect_to(post_url(:id => @comment.post, :anchor => dom_id(@comment)))
    else
      render :action => "new"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment #{@comment} has been removed."
    redirect_to(dashboard_posts_url)
  end

  private

  def grab_post
    @post = Post.find(params[:post_id])
  end
end
