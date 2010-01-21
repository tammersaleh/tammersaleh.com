class CommentsController < InheritedResources::Base
  belongs_to :post
  skip_before_filter :require_user, :only => [:create]

  actions :create, :destroy

  def create
    @comment = build_resource

    if verify_recaptcha(:model => @comment) and @comment.save
      flash[:notice] = "Thanks for commenting, #{@comment.submitter_name}."
      redirect_to(post_url(:id => @comment.post, :anchor => dom_id(@comment)))
    else
      render :action => "new"
    end
  end

  def destroy
    destroy! do |format|
      format.html { redirect_to(dashboard_posts_url) }
    end
  end
end
