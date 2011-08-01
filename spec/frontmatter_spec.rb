#!/bin/env rspec

require "spec_helper"

describe "Given a page with frontmatter" do
  before do
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %head
                        %title= meta[:title]
                      %h1 Layout
                      = yield
                    EOF

    create_template("page_with_frontmatter.html.haml", 
                    <<-EOF)
                      ---
                      title: Title for this post.
                      ---
                      This is a post.
                    EOF
  end

  context "GET /page_with_frontmatter" do
    before { visit "/page_with_frontmatter" }

    it "renders the page" do
      page.source.should =~ /This is a post/
    end
    
    it "renders the layout" do
      page.should have_selector('h1:contains("Layout")')
    end

    it "hands the frontmatter to the layout" do
      page.should have_selector('title:contains("Title for this post.")')
    end
  end
end


