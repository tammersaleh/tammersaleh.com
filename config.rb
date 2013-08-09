require 'susy'

# compass_config do |config|
#   config.output_style = :compact
# end

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
  def img_holder(opts = {})
    return "Missing Image Dimension(s)" unless opts[:width] && opts[:height]
    return "Invalid Image Dimension(s)" unless opts[:width].to_s =~ /^\d+$/ && opts[:height].to_s =~ /^\d+$/

    img  = "<img data-src=\"holder.js/#{opts[:width]}x#{opts[:height]}/auto"
    img << "/#{opts[:bgcolor]}:#{opts[:fgcolor]}" if opts[:fgcolor] && opts[:bgcolor]
    img << "/text:#{opts[:text].gsub(/'/,"\'")}" if opts[:text]
    img << "\" width=\"#{opts[:width]}\" height=\"#{opts[:height]}\">"

    img
  end

end

# Build-specific configuration
configure :build do
end

Time.zone = "Pacific Time (US & Canada)"

activate :blog do |blog|
  blog.prefix = "posts"
  blog.permalink = ":title.html"
end

activate :directory_indexes

# The file s3.yml should be in the project root, and contain something like this:
#
#   access_key: 'iam access key'
#   secret:     'iam secret'

s3_config = YAML::load_file('s3.yml')

activate :s3_sync do |s3_sync|
  s3_sync.bucket                = 'tammersaleh.com'
  s3_sync.region                = 'us-west-1'
  s3_sync.aws_access_key_id     = s3_config['access_key']
  s3_sync.aws_secret_access_key = s3_config['secret']
  s3_sync.delete                = true
  s3_sync.after_build           = false # We chain after the build step by default. This may not be your desired behavior...
  s3_sync.prefer_gzip           = true
end

