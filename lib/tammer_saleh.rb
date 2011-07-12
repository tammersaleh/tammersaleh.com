require "bundler"
Bundler.require

$LOAD_PATH << File.join(File.dirname(__FILE__), "tammer_saleh")
p $LOAD_PATH.last

require 'padrino-core/application/rendering'
require 'active_support/hash_with_indifferent_access'
require 'unindent'
require 'front_matter'

class TammerSaleh < Sinatra::Base
  include FrontMatter

  register Padrino::Rendering
  
  set :root, File.expand_path(File.dirname(__FILE__) + '/../')

  def render_template_with_layout(name)
    set_page_data(front_matter_from_file(first_template_matching(name)))
    render :"#{name}", :layout => :"application.html", :layout_engine => :haml
  end

  get %r{^/([^.]+)$} do |name|
    render_template_with_layout(name)
  end

  get "/" do
    render_template_with_layout(:index)
  end

  get "/*.*" do |name, ext|
    render :"#{name}", :layout => false
  end

  def set_page_data(data)
    @page = data
  end

  helpers do
    def page
      @page
    end
  end
end

