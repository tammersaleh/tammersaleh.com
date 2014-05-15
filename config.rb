::I18n.config.enforce_available_locales = false

require 'bootstrap-sass'
require "active_support/core_ext/array"
require 'dotenv'
require 'animate-scss'
Dotenv.load

set :build_dir, ".build"
set :markdown, enable_coderay: false

compass_config do |config|
  config.output_style = :compact
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
activate :minify_css
# This breaks the site.
# activate :minify_javascript

helpers do
  # Calculate the years for a copyright
  def copyright_years(start_year)
    end_year = Date.today.year
    if start_year == end_year
      start_year.to_s
    else
      start_year.to_s + '-' + end_year.to_s
    end
  end

  # Holder.js image placeholder helper
  def img_holder(width, height, opts = {})
    img  = "<img data-src=\"holder.js/#{width}x#{height}/auto"
    img << "/#{opts[:bgcolor]}:#{opts[:fgcolor]}" if opts[:fgcolor] && opts[:bgcolor]
    img << "/text:#{opts[:text].gsub(/'/,"\'")}" if opts[:text]
    img << "\" width=\"#{width}\" height=\"#{height}\">"

    img
  end

  def github_edit_url
    p = Pathname(current_page.source_file).relative_path_from(Pathname(root))
    "https://github.com/tsaleh/tammersaleh.com/edit/master/#{p}"
  end
  
  def index_article_background_url(article)
    "#{article.url}cover.png"
  end

  def img(name, path)
    "![#{name}](#{current_page.url + path})"
  end

  def vimeo_embed(vimeo_id, opts = {})
    w = opts[:width] || 500
    h = opts[:height] || 280
    "<iframe src='//player.vimeo.com/video/#{vimeo_id}?title=0&byline=0&portrait=0' width='#{w}' height='#{h}' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
  end
end

# Build-specific configuration
configure :build do
end

Time.zone = "Pacific Time (US & Canada)"

activate :blog do |blog|
  blog.prefix = "posts"
  blog.permalink = ":title.html"
  blog.layout = "post"
  blog.default_extension = ".markdown.erb"
  blog.new_article_template = "scripts/article.tt"
end

page "/posts.atom", layout: false
page "/404.html", :directory_index => false

activate :directory_indexes
activate :cache_buster

module Middleman::Blog::BlogArticle
  def body_with_fixed_img_tags
    body.gsub(%r{src="/posts.atom(.*)}, 'src="http://tammersaleh.com' + url + '\1')
  end
end
