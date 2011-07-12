#!/bin/env rspec

require "spec_helper"

describe "Given a file with front matter commented by //" do
  include FrontMatter
  before do
    create_template("file", 
                    <<-EOF)
                      // ---
                      // title: "Title for this post."
                      // ---
                      This is a post.
                    EOF
  end

  describe "front_matter_from_file(filename)" do
    before do
      @out = front_matter_from_file(File.join(TammerSaleh.settings.views, "file"))
    end

    it "returns a hash" do
      @out.should respond_to(:[])
    end
  end
end

