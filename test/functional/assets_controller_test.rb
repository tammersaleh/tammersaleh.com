require File.dirname(__FILE__) + '/../test_helper'

class AssetsControllerTest < ActionController::TestCase
  should_deny_access_on("GET to /assets")     { get :index }
  should_deny_access_on("GET to /assets/new") { get :new }
  should_deny_access_on("POST to /assets")    { post :create }

  context "given an asset" do
    setup { @asset = Factory(:asset) }
    should_deny_access_on("PUT to /assets/:id")    { put :update,     :id => @asset.to_param }
    should_deny_access_on("DELETE to /assets/:id") { delete :destroy, :id => @asset.to_param }
  end

  as_a_logged_in_user do
    context "on GET to /assets" do
      setup { get :index }
      should_assign_to :assets
      should_render_template :index
    end

    context "on GET to /assets/new" do
      setup { get :new }
      should_assign_to :asset
      should_render_template :new
    end

    context "on POST to /assets with good values" do
      setup { post :create, :asset => {:asset_file_name => "file1", :asset_content_type => "text/plain"} }
      should_set_the_flash_to %r{created}i
      should "send the user to the index, with the asset shown" do
        assert_redirected_to assets_url(:anchor => "asset_#{assigns(:asset).id}")
      end
    end

    context "given an asset" do
      setup { @asset = Factory(:asset) }

      context "on GET to /assets/:id" do
        setup { get :show, :id => @asset.to_param }
        should_assign_to :asset
        should_render_template :show
      end

      context "on GET to /assets/:id/edit" do
        setup { get :edit, :id => @asset.to_param }
        should_assign_to :asset
        should_render_template :edit
      end

      context "on PUT to /assets/:id with good values" do
        setup { put :update, :id => @asset.to_param, :asset => {:description => "new"} }
        should_set_the_flash_to %r{updated}i
        should "send the user to the index, with the asset shown" do
          assert_redirected_to assets_url(:anchor => "asset_#{assigns(:asset).id}")
        end
      end

      context "on DELETE to /assets/:id" do
        setup { delete :destroy, :id => @asset.to_param }
        should_redirect_to("assets_url") { assets_url }
        should_set_the_flash_to %r{destroyed}i
      end
    end
  end
end
