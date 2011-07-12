require "spec_helper"

describe "given a layout" do
  before do
    create_template("layouts/application.html.haml", "%h1 Layout\n= yield")
  end

  describe "and a haml template named index.html.haml" do
    before { create_template("index.html.haml", "%h1 Haml") }

    context "on GET to /" do
      before { visit "/" }

      it "renders the template" do
        page.should have_selector('h1:contains("Haml")')
      end
      
      it "renders the layout" do
        page.should have_selector('h1:contains("Layout")')
      end
    end
  end
end


