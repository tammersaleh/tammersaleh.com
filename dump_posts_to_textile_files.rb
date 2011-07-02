#!/usr/bin/env ruby script/runner

new_posts_root = "/Users/tsaleh/code/tsaleh/tsaleh.github.com/_posts"

Post.all.each do |post|
  date = post.published? ? post.published_at : post.created_at
  date_part = date.strftime("%Y-%m-%d")
  filename = "#{new_posts_root}/#{date_part}-#{post.slug}.textile"
  puts filename
  File.open(filename, "w+") do |f|
    f.puts "---"
    f.puts "layout: post"
    f.puts "title: \"#{post.title}\""
    # f.puts "permalink: /posts/#{post.slug}"
    f.puts "published: #{post.published? ? 'true' : 'false'}"
    f.puts "---"
    f.puts
    f << post.body
  end
end
