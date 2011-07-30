require "bundler"
Bundler.require

$LOAD_PATH << File.join(File.dirname(__FILE__), "tammer_saleh")

require 'padrino-core/application/rendering'
require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/object/blank'

Dir[File.join(File.dirname(__FILE__), "tammer_saleh/**/*.rb")].each do |f|
  require f
end

class TammerSaleh < Sinatra::Base
  register Padrino::Rendering
  
  set :root, File.expand_path(File.dirname(__FILE__) + '/../')

  def render_template_with_layout(name)
    page = Page.new(name)
    set_data(page.meta)
    render :"#{name}", :layout => page.layout, :layout_engine => :haml
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

  def set_data(data)
    @data = data
  end

  helpers do
    def data
      @data
    end

    def posts
      PostCollection.new.posts
    end
  end
end

