require "spec_helper"

describe "given a textile template with an image link" do
  before do
    create_template("layouts/application.html.haml", "%h1 Layout\n= yield")
    create_template("posts/bar.html.textile", "%file/large.jpg")
  end

  context "the rendered page" do
    before { visit "/posts/bar" }
    subject { page }

    it { should have_selector('img[src="/attachments/images/file/large.jpg"]') }
  end
end

