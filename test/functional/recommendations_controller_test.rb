require 'test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  as_a_logged_in_user do
    context "on GET to /recommendations/new" do
      setup { get :new }

      should_render_template :new
      should_respond_with :success
      should_not_set_the_flash
    end

    context "on POST to /recommendations with good values" do
      setup do
        post :create, 
             :recommendation => {
               :quote => "Quote",
               :who => "Who",
               :where => "Where",
               :where_url => "Where url",
               :position => "Position",
               :company => "Company",
               :company_url => "Company url",
             }
      end

      should_redirect_to("recommendation page") { recommendation_path(assigns(:recommendation)) }
      should_set_the_flash_to /created/i
      should_create(:recommendation)
    end

    context "given a recommendation" do
      setup { @recommendation = Factory(:recommendation) }

      context "on GET to /recommendations/" do
        setup { get :index }

        should_render_template :index
        should_respond_with :success
        should_not_set_the_flash
      end

      context "on GET to /recommendations/:id" do
        setup { get :show, :id => @recommendation.to_param }

        should_render_template :show
        should_respond_with :success
        should_not_set_the_flash
      end

      context "on GET to /recommendations/:id/edit" do
        setup { get :edit, :id => @recommendation.to_param }

        should_render_template :edit
        should_respond_with :success
        should_not_set_the_flash
      end

      context "on PUT to /recommendations/:id with good values" do
        setup do
          put :update, 
              :id => @recommendation.to_param, 
              :recommendation => {
                :quote => "Quote",
                :who => "Who",
                :where => "Where",
                :where_url => "Where url",
                :position => "Position",
                :company => "Company",
                :company_url => "Company url",
              }
        end

        should_redirect_to("recommendations page") { recommendation_path(@recommendation) }
        should_set_the_flash_to /updated/i
      end

      context "on DELETE to /recommendations/:id" do
        setup { delete :destroy, :id => @recommendation.to_param }
        should_redirect_to("recommendations index") { recommendations_path }
        should_destroy(:recommendation)
      end
    end
  end
end
