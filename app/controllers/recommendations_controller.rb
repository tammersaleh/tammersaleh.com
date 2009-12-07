class RecommendationsController < InheritedResources::Base
  actions :index, :new, :create, :edit, :update, :destroy
  # belongs_to :user, :finder => :find_by_username!, :optional => true
end
