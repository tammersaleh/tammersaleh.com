require File.dirname(__FILE__) + '/../test_helper'

class AssetTest < ActiveSupport::TestCase
  context "An Asset" do
    setup { @asset = Factory(:asset) }

    should_have_attached_file :asset

    should "return the basename on to_s" do
      assert_equal 'file.jpg', @asset.to_s
    end
  end
end
