require "spec_helper"

describe "given a layout and some assets" do
  before do
    create_template("layouts/application.html.haml", "%h1 Layout\n= yield")
    create_template("one.css.scss",                  ".foo {color: red}")
    create_template("nested/file.css.scss",          ".foo {color: yellow}")
    create_template("two.js.coffee",                 'alert "Coffee"')
    create_template("three.css.sass",                ".foo\n  :clear both\n")
  end

  it "doesn't render the layout when getting a CSS file" do
    visit "/one.css"
    page.should_not have_selector('h1:contains("Layout")')
  end

  it "doesn't render the layout when getting a JS file" do
    visit "/two.js"
    page.should_not have_selector('h1:contains("Layout")')
  end

  it "renders the scss as css" do
    visit "/one.css"
    page.source.should match(%r{color: red;})
  end

  it "renders the sass as css" do
    visit "/three.css"
    page.source.should match(%r{clear: both;})
  end

  it "renders the coffeescript as js" do
    visit "/two.js"
    page.source.should match(%r{alert\("Coffee"\)})
  end

  it "renders a template if a cachebuster is used" do
    visit "/two.js?2348347"
    page.source.should match(%r{alert\("Coffee"\)})
  end

  it "renders the nested asset without issue" do
    visit "/nested/file.css"
    page.source.should match(%r{color: yellow;})
  end
end

describe "An asset in /public" do
  before do
    create_asset("straight.js", 'javascript!')
  end

  it "is rendered without processing" do
    visit "/straight.js"
    page.source.should == "javascript!"
  end
end

