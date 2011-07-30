#!/bin/env rspec

require "spec_helper"

describe "when there are no posts" do
  describe PostCollection do
    it { should be_empty }
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

  describe PostCollection do
    it { should_not be_empty }

    its("posts") { should_not be_empty }

    it "should return the newest post first" do
      subject.posts.first.meta[:title].should == "Second post"
    end
  end
end
