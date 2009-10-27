class UsersController < InheritedResources::Base
  skip_before_filter :require_user, :only => [:new, :create]
  before_filter :require_self, :except => [:new, :create, :show]

  actions :new, :create, :show, :edit, :update

  def create
    create! do |success, failure|
      success.html { redirect_to root_url }
    end
  end
  
  private

  def require_self
    unless current_user.id == params[:id].to_i
      deny_access(:flash => "You cannot access this page.", :redirect_to => root_url)
    end
  end
end
