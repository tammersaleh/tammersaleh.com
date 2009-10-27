class UserActivationsController < ApplicationController
  skip_before_filter :require_user, :only => [:show, :update]

  def show
    @user_activation = UserActivation.find(params[:id])
    deny_access(:redirect_to => signup_url, :flash => "Invalid activation url") unless @user_activation.valid?
  end

  def update
    @user_activation = UserActivation.find(params[:id])
    if @user_activation.update_attributes(params[:user_activation])
      flash[:notice] = "Welcome!"
      redirect_to root_url
    else
      render :action => "show"
    end
  end
end
