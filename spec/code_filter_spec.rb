require "spec_helper"

describe "given a textile template with a code sample" do
  before do
    create_template("layouts/application.html.haml", "%h1 Layout\n.content\n  ~ yield")
    create_template("foo.html.textile", <<-EOS) 
      @@@ ruby
      foo
      bar
      @@@
    EOS

    create_template("bar.html.textile", <<-EOS) 
      @@@
      [branch "master"]
        remote = origin
        merge = refs/heads/master
      @@@
    EOS

  end

  context "the rendered page" do
    before { visit "/foo" }
    subject { page }

    it { should have_selector('pre code.ruby') }
  end

  context "the rendered page" do
    before { visit "/bar" }
    subject { page }

    it { should have_selector('pre code') }
    it "should not fuck up the indenting" do
      page.source.should match(%r{\S  remote = origin})
    end
  end
end

