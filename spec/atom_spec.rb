#!/bin/env rspec

require "spec_helper"

describe "Given some blog posts" do
  before do
    create_template("posts/a_post.html.haml", 
                    <<-EOF)
                      ---
                      title: First post
                      date:  1997-07-01
                      ---
                      %blockquote This is the first post.
                    EOF

    create_template("posts/another_post.html.haml", 
                    <<-EOF)
                      ---
                      title: Second post
                      date:  2011-01-10
                      ---
                      This is the second post.
                    EOF

    create_template("posts/textile_post.html.textile", 
                    <<-EOF)
                      ---
                      title: Textile post
                      date:  2010-01-10
                      ---

                      bq. Textile post.
                    EOF
  end

  context "GET /posts.atom" do
    before { visit "/posts.atom" }

    it "renders the feed as rss" do
      page.should have_selector("rss[version='2.0']")
      page.should have_selector("rss title")
      page.response_headers['Content-Type'].should == "application/rss+xml"
    end
    
    it "renders xml for the first post" do
      page.should have_selector('rss channel item title:contains("First post")')
      page.source.should include("http://www.example.com/posts/a_post")
    end

    it "renders xml for the second post" do
      page.should have_selector('rss channel item title:contains("Second post")')
      page.source.should include("http://www.example.com/posts/another_post")
    end
  end
end
