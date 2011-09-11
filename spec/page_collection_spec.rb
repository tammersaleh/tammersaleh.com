#!/bin/env rspec

require "spec_helper"

describe "Given some drafts" do
  before do
    create_template("drafts/a_post.html.haml", 
                    <<-EOF)
                      ---
                      title: First draft
                      date:  1997-07-01
                      ---
                      This is the first post.
                    EOF

    create_template("drafts/another_post.html.haml", 
                    <<-EOF)
                      ---
                      title: Second draft
                      date:  2011-01-10
                      ---
                      This is the second post.
                    EOF
  end

  describe "PageCollection.new('drafts')" do
    before { @collection = PageCollection.new('drafts')}
    subject { @collection }

    it { should_not be_empty }
    it "should return the newest draft first" do
      @collection.first.meta[:title].should == "Second draft"
    end
  end
end

describe "Given some posts" do
  before do
    create_template("posts/a_post.html.haml", 
                    <<-EOF)
                      ---
                      title: First post
                      date:  1997-07-01
                      ---
                      This is the first post.
                    EOF

    create_template("posts/another_post.html.haml", 
                    <<-EOF)
                      ---
                      title: Second post
                      date:  2011-01-10
                      ---
                      This is the second post.
                    EOF
  end

  describe "PageCollection.new('posts')" do
    before { @collection = PageCollection.new('posts')}
    subject { @collection }

    it { should_not be_empty }
    it "should return the newest post first" do
      @collection.first.meta[:title].should == "Second post"
    end
  end
end
