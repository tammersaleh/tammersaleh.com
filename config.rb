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

# module URLWithoutTrailingSlash
#   def url
#     super.sub(%r{/$}, "")
#   end
# end
# 
# class Middleman::Sitemap::Resource
#   prepend(URLWithoutTrailingSlash)
# end

