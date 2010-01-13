xml.instruct!
 
xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.84" do
  xml.url do
    xml.loc "http://#{request.host}/"
    xml.lastmod Time.now.to_s(:w3c)
    xml.changefreq "always"
  end
 
  @pages.each do |page|
    xml.url do
      xml.loc "http://#{request.host}#{page[:url]}"
      xml.lastmod Time.now.to_s(:w3c)
      xml.changefreq "daily"
      xml.priority 0.9
    end
  end

  @posts.each do |post|
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.created_at.to_s(:w3c)
      xml.changefreq "weekly"
      xml.priority 0.6
    end
  end
end

