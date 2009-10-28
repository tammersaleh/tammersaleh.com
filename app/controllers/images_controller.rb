class ImagesController < ApplicationController
  skip_before_filter :require_user, :only => [:show]

  def index
    @images = Image.ordered.find(:all)
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params[:image])

    if @image.save
      flash[:notice] = "#{@image} was successfully created."
      redirect_to images_url(:anchor => dom_id(@image))
    else
      render :action => "new"
    end
  end

  def update
    @image = Image.find(params[:id])

    if @image.update_attributes(params[:image])
      flash[:notice] = "#{@image} was successfully updated."
      redirect_to images_url(:anchor => dom_id(@image))
    else
      render :action => "edit"
    end
  end

  def destroy
    @image = Image.find(params[:id])
    flash[:notice] = "#{@image} was removed."
    @image.destroy
    redirect_to(images_url)
  end
end
