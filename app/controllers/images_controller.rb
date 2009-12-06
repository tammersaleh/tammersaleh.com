class ImagesController < InheritedResources::Base
  skip_before_filter :require_user, :only => [:show]

  def create
    create! do |success, failure|
      success.html { redirect_to images_url(:anchor => dom_id(@image)) }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to images_url(:anchor => dom_id(@image)) }
    end
  end
end
