#!/bin/env rspec

require "spec_helper"

describe "Given a haml file without frontmatter, Page" do
  before do
    @path = "/file"
    create_template("#{@path}.html.haml", "%h1 This is a post.")
    @page = Page.new(@path)
  end
  subject { @page }

  its(:engine) { should == :haml }
  its(:meta)   { should be_a(HashWithIndifferentAccess) }
  its(:meta)   { should be_empty }
  its(:url)    { should == "/file" }
end

describe "Given a textile file without frontmatter, Page" do
  before do
    @path = "/file"
    create_template("#{@path}.html.textile", "h1. This is a post.")
    @page = Page.new(@path)
  end
  subject { @page }

  its(:engine) { should == :textile }
end

describe "Given a file with front matter" do
  before do
    @path = "file"
    create_template("#{@path}.html.haml", 
                    <<-EOF)
                      ---
                      title: "Title for this post."
                      date:  2011-01-10
                      ---
                      %h1 This is a post.
                    EOF
  end

  describe "Page.new(filename)" do
    before { @page = Page.new(@path) }
    subject { @page }

    its(:meta)   { should be_a(HashWithIndifferentAccess) }
    its(:url)    { should == "/file" }
    its(:source) { should match("%h1 This is a post.") }
    its(:source) { should_not match("Title for this post") }

    describe "#meta" do
      before { @out = @page.meta }

      it "returns the title in the hash" do
        @out[:title].should == "Title for this post."
      end

      it "returns the date as a Date object" do
        @out[:date].should be_a Date
      end
    end
  end
end

describe "Page.new(directory/file)" do
  before do
    @path = "directory/file"
    create_template("#{@path}.html.haml", "This is a post.")
    @page = Page.new(@path)
  end
  subject { @page }

  context "with a layout named application.html.haml" do
    before do
      create_template("layouts/application.html.haml", "%h1 Layout\n= yield")
    end

    its(:layout) { should == "application.html" }

    context "and a layout named directory.html.haml" do
      before do
        create_template("layouts/directory.html.haml", "%h1 Directory\n= yield")
      end

      its(:layout) { should == "directory.html" }
    end
  end

  describe "#url" do
    before { @out = @page.url }

    it "returns the path of the page" do
      @out.should == "/directory/file"
    end
  end
end

