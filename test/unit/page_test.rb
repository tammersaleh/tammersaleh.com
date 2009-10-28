require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  should_have_db_columns :title, :body, :published, :slug, :description

  # should_have_named_scope :ordered, :order => "title"
  # should_have_named_scope "show_unpublished(true)", {}
  # should_have_named_scope "show_unpublished(nil)", :conditions => {:published => true}
    
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
    
    should "default to not a navigation page" do
      assert !@page.navigation?
    end
  end

  context "given some published and unpublished pages" do
    setup do
      Factory(:page, :published => true )
      Factory(:page, :published => false)
      Factory(:page, :published => true, :navigation => true)
      Factory(:page, :published => false, :navigation => true)
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

    context "navigation_pages" do
      setup { @pages = Page.navigation_pages }
      
      should "return all navigation pages" do
        assert @pages.reject(&:navigation?).empty?
      end
    end
  end
end
