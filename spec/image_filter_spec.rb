require "spec_helper"

describe "given a textile template with an image link " do
  before { create_template("layouts/application.html.haml", "%h1 Layout\n= yield") }

  describe "and an image link" do
    before do
      create_asset("images/file/original.jpg", "image data") 
      create_template("posts/bar.html.textile", "%file.jpg large%") 
    end

    context "the rendered page" do
      before { visit "/posts/bar" }
      subject { page }

      it { should have_selector('img[src="/images/file/large.jpg"]') }
    end
  end

  describe "and an image link with metadata" do
    before do
      create_template("posts/bar.html.textile", "%file.jpg%") 
      create_asset("images/file/original.jpg", "image data") 
      create_asset("images/file/meta.yml", <<-EOS) 
                                             --- 
                                             :description: Me Speaking
                                             :source_url: ""
                                           EOS
    end

    context "the rendered page" do
      before { visit "/posts/bar" }
      subject { page }

      it { should have_selector('img[alt="Me Speaking"]') }
      it { should_not have_selector('a img') }
    end
  end

  describe "and an image link with metadata that includes a url" do
    before do
      create_template("posts/bar.html.textile", "%file.jpg%") 
      create_asset("images/file/original.jpg", "image data") 
      create_asset("images/file/meta.yml", <<-EOS) 
                                                         --- 
                                                         :description: ""
                                                         :source_url: http://google.com
                                                       EOS
    end

    context "the rendered page" do
      before { visit "/posts/bar" }
      subject { page }

      it { should_not have_selector('img[alt]') }
      it { should have_selector('a[href="http://google.com"] img') }
    end
  end

  describe "and an image link without a file" do
    before { create_template("posts/bar.html.textile", "%bad_file.jpg%") }

    context "the rendered page" do
      before { visit "/posts/bar" }
      subject { page }

      it { should_not have_selector('img') }
      it { should have_selector('.warning') }
      it { page.source.should match("unknown") }
    end
  end
end

