#!/bin/env rspec

require "spec_helper"

describe "The blog" do
  before do
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %head
                        %title= page[:title]
                      %h1 Layout
                      = yield
                    EOF

    create_template("posts/a_post.html.haml", 
                    <<-EOF)
                      // ---
                      // title: Title for this post.
                      // ---
                      This is a post.
                    EOF
  end

  context "GET /posts/a_post" do
    before { visit "/posts/a_post" }

    it "renders the post" do
      page.source.should =~ /This is a post/
    end
    
    it "renders the layout" do
      page.should have_selector('h1:contains("Layout")')
    end

    it "hands the frontmatter to the layout" do
      # puts page.source
      page.should have_selector('title:contains("Title for this post.")')
    end
  end
end


