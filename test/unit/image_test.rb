require File.dirname(__FILE__) + '/../test_helper'

class ImageTest < ActiveSupport::TestCase
  context "An Image" do
    setup { @image = Factory(:image) }
    subject { @image }

    should_have_attached_file :image
    
    should "return the basename on to_s" do
      assert_equal 'file.jpg', @image.to_s
    end

    should_have_db_column :source_url
  end

  context "An unsaved Image" do
    setup { @image = Factory.build(:image) }
    subject { @image }

    should "return the basename on to_s" do
      assert_equal 'file.jpg', @image.to_s
    end
  end
end
