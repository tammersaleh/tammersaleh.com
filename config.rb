require 'bootstrap-sass'
require "active_support/core_ext/array"

compass_config do |config|
  config.output_style = :compact
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

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
end

# Build-specific configuration
configure :build do
end

Time.zone = "Pacific Time (US & Canada)"

activate :blog do |blog|
  blog.prefix = "posts"
  blog.permalink = ":title.html"
  blog.layout = "post"
end

page "/posts.atom", layout: false

activate :directory_indexes
activate :cache_buster

# The file s3.yml should be in the project root, and contain something like this:
#
#   access_key: 'iam access key'
#   secret:     'iam secret'

aws_config = YAML::load_file('s3.yml')

# http://tammersaleh.com.s3-website-us-west-1.amazonaws.com
activate :s3_sync do |opts|
  opts.bucket                = 'tammersaleh.com'
  opts.region                = 'us-west-1'
  opts.aws_access_key_id     = aws_config['access_key']
  opts.aws_secret_access_key = aws_config['secret']
  opts.delete                = true
  opts.after_build           = false
  opts.prefer_gzip           = true
end

# http://d2x1ickoeyyexb.cloudfront.net
activate :cloudfront do |opts|
  opts.access_key_id     = aws_config['access_key']
  opts.secret_access_key = aws_config['secret']
  opts.distribution_id   = aws_config["distribution_id"]
  # opts.filter            = /.html/
  opts.after_build       = false
end

