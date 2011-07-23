require "spec_helper"

describe "given a layout" do
  before do
    create_template("layouts/application.html.haml", "%h1 Layout\n= yield")
  end

  describe "and a haml template" do
    before { create_template("bar.html.haml", "%h1 Haml") }

    context "on GET to /bar" do
      before { visit "/bar" }

      it "renders the template" do
        page.should have_selector('h1:contains("Haml")')
      end
      
      it "renders the layout" do
        page.should have_selector('h1:contains("Layout")')
      end
    end
  end

  describe "and a nested haml template" do
    before { create_template("foo/bar.html.haml", "%h2 Nested Page") }

    context "on GET to /foo/bar" do
      before { visit "/foo/bar" }

      it "renders the template" do
        page.should have_selector('h2:contains("Nested Page")')
      end
    end
  end

  describe "and a textile template" do
    before { create_template("bar.html.textile", "h1. Textile") }

    context "on GET to /bar" do
      before { visit "/bar" }

      it "renders the template" do
        page.should have_selector('h1:contains("Textile")')
      end
    end
  end
end


