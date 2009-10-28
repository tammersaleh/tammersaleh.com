require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase
  should_have_many :comments
  
  should_have_db_columns :title, :body, :published_at, :slug
  # should_have_named_scope "limit(10)", :limit => 10
  # should_have_named_scope :ordered, :order => "published_at DESC"
  # should_have_named_scope "show_unpublished(true)", {}
  # should_have_named_scope "show_unpublished(nil)", :conditions => "published_at is not null"
  # should_have_named_scope "unpublished", :conditions => "published_at is null"

  context "A new Post" do
    setup { @post = Post.new }
    
    should "default to unpublished" do
      assert !@post.published?
    end

    should "have an alias published for published?" do
      @post.expects(:published?).returns(:foo)
      assert_equal :foo, @post.published
    end
  end

  context "An unpublished post" do
    setup { @post = Factory(:post, :published_at => nil) }

    should "default to published_at of nil" do
      assert_nil @post.published_at
    end

    context "that's been published" do
      setup { @post.update_attributes(:published_at => 5.days.ago) }

      should "be published" do
        assert @post.published?
      end

      context "and published again" do
        setup { @post.update_attributes(:published => true) }

        should "not update the published_at flag" do
          assert_in_delta @post.published_at, 5.days.ago, 1.minute
        end
      end
    end

    context "that has the published flag set" do
      setup { @post.update_attributes(:published => true) }

      should "default to published_at of time now" do
        assert_in_delta @post.published_at, Time.now, 1.minute
      end
    end
  end
  
  context "A Post" do
    setup { @post = Factory(:post, :title => "Boogidy boogidy boo!") }
    subject { @post }

    should_validate_uniqueness_of :slug
    should_validate_presence_of :title, :body
    should_allow_values_for :slug, "abc123", "ab-c_d"
    should_not_allow_values_for :slug, "a b", "don't", "b.c", "*", "&", "$"

    should "return its title on to_s" do
      assert_equal @post.title, @post.to_s
    end

    should "return the slug on to_param" do
      assert_equal @post.slug, @post.to_param
    end
    
    should "set the slug from the title" do
      assert_equal 'boogidy-boogidy-boo', @post.slug
    end

    context "and a post with the same title" do
      setup do
        @new_post = Factory(:post, :title => @post.title)
      end

      should "have different slugs" do
        assert_not_equal @post.slug, @new_post.slug
      end
    end
  end

  context "given a bunch of published and unpublished posts" do
    setup do
      Factory(:post, :published => true )
      Factory(:post, :published => false)
    end
    
    context "Post.show_unpublished(false)" do
      setup { @posts = Post.show_unpublished(false) }
      
      should "return only published posts" do
        assert @posts.reject(&:published?).empty?
      end
    end

    context "Post.show_unpublished(true)" do
      setup { @posts = Post.show_unpublished(true) }
      
      should "return all posts" do
        assert_equal Post.count, @posts.count
      end
    end
  end
end
