require "spec_helper"

describe "given a textile template with a code sample" do
  before do
    create_template("layouts/application.html.haml", <<-EOS)
                                                       %h1 Layout
                                                       .content
                                                         ~ yield
                                                     EOS
    create_template("index.html.haml", <<-EOF)
                                         This is the Blog!
                                         - collection("posts").each do |post|
                                           %h2= post.meta[:title]
                                           ~ render_page(post)
                                       EOF
    create_template("posts/bar.html.textile", <<-EOS) 
                                                @@@ ruby
                                                [branch "master"]
                                                  remote = origin
                                                  merge = refs/heads/master
                                                @@@
                                              EOS

  end

  context "the rendered page" do
    before { visit "/posts/bar" }
    subject { page }

    it { should have_selector('pre code.ruby') }
    it "should not fuck up the indenting" do
      page.source.should match(%r{\S  remote = origin})
    end
  end

  context "the posts index" do
    before { visit "/" }
    subject { page }

    it { should have_selector('pre code.ruby') }
    it "should not fuck up the indenting" do
      page.source.should match(%r{\S  remote = origin})
    end
  end
end

