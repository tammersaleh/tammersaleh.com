require "bundler"
Bundler.require

$LOAD_PATH << File.join(File.dirname(__FILE__), "tammer_saleh")

require 'padrino-core/application/rendering'
require 'padrino-helpers'

require 'active_support/hash_with_indifferent_access'
require 'active_support/core_ext/object/blank'

Dir[File.join(File.dirname(__FILE__), "tammer_saleh/**/*.rb")].each do |f|
  require f
end

Tilt.register MyRedClothTemplate, "textile"

class TammerSaleh < Sinatra::Base
  register Padrino::Rendering
  register Padrino::Helpers
  
  set :root, File.expand_path(File.dirname(__FILE__) + '/../')

  def render_page_with_layout(page)
    render_page(page, :layout => page.layout, 
                      :layout_engine => :haml)
  end

  get %r{^/([^.]+)$} do |name|
    render_page_with_layout(Page.new(name))
  end

  get "/" do
    render_page_with_layout(Page.new(:index))
  end

  get "/*.*" do |name, ext|
    render :"#{name}", :layout => false
  end

  helpers do
    def render_page(page, opts = {})
      opts[:locals] ||= {}
      opts[:locals][:meta] = page.meta
      send(page.engine, page.source, opts)
    end
 
    def posts
      PostCollection.new.posts
    end
  end
end

