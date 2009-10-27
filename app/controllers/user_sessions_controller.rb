class UserSessionsController < ApplicationController
  skip_before_filter :require_user,    :only => [:new, :create]
  before_filter      :require_no_user, :only => [:new, :create]

  def new
    @user = User.new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Welcome, #{@user_session.user}"
      redirect_back_or root_url
    else
      @user = User.new
      render :action => "new"
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Good bye, #{current_user}."
    redirect_back_or new_user_session_url
  end
end

