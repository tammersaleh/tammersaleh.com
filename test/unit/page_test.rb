require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  should_have_db_columns :title, :body, :published, :slug, :description

  context "A page" do
    setup { @page = Factory(:page) }
    subject { @page }

    should_validate_presence_of :title, :body
    should_allow_values_for :slug, "abc123", "ab-c_d"
    should_not_allow_values_for :slug, "a b", "don't", "b.c", "*", "&", "$"
    should_validate_uniqueness_of :slug 

    should "return its title on to_s" do
      assert_equal @page.title, @page.to_s
    end
  end
  
  context "A new page" do
    setup { @page = Page.new }
    
    should "default to unpublished" do
      assert !@page.published?
    end
  end

  context "given some published and unpublished pages" do
    setup do
      Factory(:page, :published => true )
      Factory(:page, :published => false)
    end
    
    context "show_unpublished(false)" do
      setup { @pages = Page.show_unpublished(false) }
      
      should "return only published pages" do
        assert @pages.reject(&:published?).empty?
      end
    end

    context "show_unpublished(true)" do
      setup { @pages = Page.show_unpublished(true) }
      
      should "return all pages" do
        assert_equal Page.count, @pages.count
      end
    end
  end
end
