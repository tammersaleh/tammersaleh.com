#!/bin/env rspec

require "spec_helper"

describe "Given some blog posts" do
  before do
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %h1 Layout
                      = yield
                    EOF
     
    create_template("layouts/posts.html.haml", 
                    <<-EOF)
                      %h1 Post Layout
                      = yield
                    EOF
     
    create_template("posts.html.haml", 
                    <<-EOF)
                      This is the Blog!
                      - collection("posts").each do |post|
                        %h2= post.meta[:title]
                        = render_page(post)
                    EOF

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

  context "GET /posts" do
    before { visit "/posts" }

    it "renders the page" do
      page.source.should =~ /This is the Blog/
    end
    
    it "renders the layout" do
      page.should have_selector('h1:contains("Layout")')
    end

    it "renders the first post title" do
      page.should have_selector('h2:contains("First post")')
    end

    it "renders the second post title" do
      page.should have_selector('h2:contains("Second post")')
    end

    it "renders the body of the haml post" do
      page.should have_selector('blockquote:contains("first post")')
    end

    it "renders the body of the textile post" do
      page.should have_selector('blockquote:contains("Textile post")')
    end
  end
end

describe "Given a blog post" do
  before do
    create_template("layouts/application.html.haml", 
                    <<-EOF)
                      %h1 Layout
                      = yield
                    EOF
     
    create_template("layouts/posts.html.haml", 
                    <<-EOF)
                      %h1 Post Layout
                      %h2= meta[:title]
                      = yield
                    EOF
     
    create_template("posts/a_post.html.haml", 
                    <<-EOF)
                      ---
                      title: First post
                      date:  1997-07-01
                      foo:   bar
                      ---
                      %blockquote This is the first post.
                    EOF
  end

  context "navigating to that post" do
    before { visit "/posts/a_post" }

    it "renders the post layout" do
      page.should have_selector('h1:contains("Post Layout")')
    end

    it "renders the post title" do
      page.should have_selector('h2:contains("First post")')
    end

    it "renders the post body" do
      page.should have_selector('blockquote:contains("This is the first post.")')
    end

    it "doesn't attempt to render the frontmatter" do
      page.source.should_not match("foo")
    end
  end

  context "navigating to that post with a trailing /" do
    before { visit "/posts/a_post/" }

    it "renders the post body" do
      page.should have_selector('blockquote:contains("This is the first post.")')
    end
  end
end


