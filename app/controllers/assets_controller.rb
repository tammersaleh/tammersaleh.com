class AssetsController < InheritedResources::Base
  skip_before_filter :require_user, :only => [:show]

  def create
    create! do |success, failure|
      success.html { redirect_to assets_url(:anchor => dom_id(@asset)) }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to assets_url(:anchor => dom_id(@asset)) }
    end
  end
end
