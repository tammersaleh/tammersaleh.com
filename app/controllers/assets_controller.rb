class AssetsController < ApplicationController
  skip_before_filter :require_user, :only => [:show]
  
  def index
    @assets = Asset.ordered.find(:all)
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])

    if @asset.save
      flash[:notice] = 'Asset was successfully created.'
      redirect_to assets_url(:anchor => dom_id(@asset))
    else
      render :action => "new"
    end
  end

  def edit
    @asset = Asset.find(params[:id])
  end

  def update
    @asset = Asset.find(params[:id])

    if @asset.update_attributes(params[:asset])
      flash[:notice] = 'Asset was successfully updated.'
      redirect_to assets_url(:anchor => dom_id(@asset))
    else
      render :action => "edit"
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    flash[:notice] = "#{@asset} was successfully removed."
    @asset.destroy
    redirect_to(assets_url)
  end
end
