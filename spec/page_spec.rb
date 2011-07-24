#!/bin/env rspec

require "spec_helper"

describe "Given a file without front matter" do
  before do
    @path = "file"
    create_template("#{@path}.html.haml", "This is a post.")
  end

  describe "Page.new(filename)" do
    before { @page = Page.new(@path) }

    describe "#meta" do
      before { @out = @page.meta }

      it "returns a HashWithIndifferentAccess" do
        @out.should be_a(HashWithIndifferentAccess)
      end

      it "returns empty" do
        @out.should be_empty
      end
    end
  end
end

describe "Given a file with front matter commented by //" do
  before do
    @path = "file"
    create_template("#{@path}.html.haml", 
                    <<-EOF)
                      // ---
                      // title: "Title for this post."
                      // date:  2011-01-10
                      // ---
                      This is a post.
                    EOF
  end

  describe "Page.new(filename)" do
    before { @page = Page.new(@path) }

    describe "#meta" do
      before { @out = @page.meta }

      it "returns a HashWithIndifferentAccess" do
        @out.should be_a(HashWithIndifferentAccess)
      end

      it "returns the title in the hash" do
        @out[:title].should == "Title for this post."
      end

      it "returns the date as a Date object" do
        @out[:date].should be_a Date
      end
    end
  end
end

# describe "Given a nested file" do
#   before do
#     @path = "directory/file"
#     create_template("#{@path}.html.haml", "This is a post.")
#   end
# 
#   describe "Page.new(filename)" do
#     before { @page = Page.new(@path) }
#     subject { @page }
# 
#     context "with a layout named application.html.haml" do
#       before do
#         create_template("layouts/application.html.haml", "%h1 Layout\\n= yield")
#       end
# 
#       its(:layout) { should == "application.html" }
# 
#       context "and a layout named directory.html.haml" do
#         before do
#           create_template("layouts/directory.html.haml", "%h1 Layout\\n= yield")
#         end
# 
#         its(:layout) { should == "directory.html" }
#       end
#     end
#   end
# end

