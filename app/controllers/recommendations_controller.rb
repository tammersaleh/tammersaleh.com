class RecommendationsController < InheritedResources::Base
  actions :index, :new, :create, :edit, :update, :destroy
  # belongs_to :user, :finder => :find_by_username!, :optional => true
  
  def create
    create! do |success, failure|
      success.html { redirect_to recommendations_url }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to recommendations_url }
    end
  end

end
