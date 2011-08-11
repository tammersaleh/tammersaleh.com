builder do |xml|
  xml.instruct! :xml, :version => '1.0'
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "Tammer Saleh"
      xml.link "http://tammersaleh.com"

      @posts.each do |post|
        xml.item do
          xml.title post[:title]
          xml.link "http://tammersaleh.com/#{post.url}"
          xml.description haml("%h1 #{post.meta[:title]}") + render_post(post)
          xml.pubDate Time.parse(post.meta[:date]).rfc822()
          xml.guid "http://tammersaleh.com/#{post.url}"
        end
      end
    end
  end
end
# atom_feed do |feed|
#   feed.title("Tammer Saleh")
#   feed.link(:rel => "self", :href => 'http://feeds.feedburner.com/TammerSaleh')
# 
#   unless @posts.empty?
#     feed.updated((@posts.first.published_at))
# 
#     @posts.each do |post|
#       feed.entry(post) do |entry|
#         entry.title(post.title)
#         entry.content(render(:partial => 'posts/atom.html.haml', 
#                              :locals  => {:post => post}), 
#                       :type => 'html')
#       
#         entry.author do |author|
#           author.name("Tammer Saleh")
#         end
#       end
#     end
#   end
# end
