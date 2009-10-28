require File.dirname(__FILE__) + '/../test_helper'

class ImagesControllerTest < ActionController::TestCase
  as_a_visitor do
    should_deny_access_on("GET to /images")     { get :index }
    should_deny_access_on("GET to /images/new") { get :new }
    should_deny_access_on("POST to /images")    { post :create }

    context "given an image" do
      setup { @image = Factory(:image) }
      should_deny_access_on("PUT to /images/:id")    { put :update,     :id => @image.to_param }
      should_deny_access_on("DELETE to /images/:id") { delete :destroy, :id => @image.to_param }
    end
  end

  as_a_logged_in_user do
    context "on GET to /images" do
      setup { get :index }
      should_assign_to :images
      should_render_template :index
    end

    context "on GET to /images/new" do
      setup { get :new }
      should_assign_to :image
      should_render_template :new
    end

    context "on POST to /images with good values" do
      setup { post :create, :image => {:image_file_name => "file1", :image_content_type => "text/plain"} }
      should_set_the_flash_to %r{created}i
      should "send the user to the index, with the image shown" do
        assert_redirected_to images_url(:anchor => "image_#{assigns(:image).id}")
      end
    end

    context "on POST to /images with bad values" do
      setup do
        Image.any_instance.stubs(:valid?).returns(false)
        post :create, :image => {} 
      end

      should_not_set_the_flash
      should_render_template :new
    end

    context "given an image" do
      setup { @image = Factory(:image) }

      context "on GET to /images/:id" do
        setup { get :show, :id => @image.to_param }
        should_assign_to :image
        should_render_template :show
      end

      context "on GET to /images/:id/edit" do
        setup { get :edit, :id => @image.to_param }
        should_assign_to :image
        should_render_template :edit
      end

      context "on PUT to /images/:id with good values" do
        setup { put :update, :id => @image.to_param, :image => {:description => "new"} }
        should_set_the_flash_to %r{updated}i
        should "send the user to the index, with the image shown" do
          assert_redirected_to images_url(:anchor => "image_#{assigns(:image).id}")
        end
      end

      context "on PUT to /images/:id with bad values" do
        setup do
          Image.any_instance.stubs(:valid?).returns(false)
          put :update, :id => @image.to_param, :image => {} 
        end

        should_not_set_the_flash
        should_render_template :edit
      end

      context "on DELETE to /images/:id" do
        setup { delete :destroy, :id => @image.to_param }
        should_redirect_to("images_url") { images_url }
        should_set_the_flash_to %r{removed}i
      end
    end
  end
end
