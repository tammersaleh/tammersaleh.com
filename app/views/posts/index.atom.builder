atom_feed do |feed|
  feed.title("Tammer Saleh")
  feed.link(:rel => "self", :href => 'http://feeds.feedburner.com/TammerSaleh')

  unless @posts.empty?
    feed.updated((@posts.first.published_at))

    @posts.each do |post|
      feed.entry(post) do |entry|
        entry.title(post.title)
        entry.content(render(:partial => 'posts/atom.html.haml', 
                             :locals  => {:post => post}), 
                      :type => 'html')
      
        entry.author do |author|
          author.name("Tammer Saleh")
        end
      end
    end
  end
end
