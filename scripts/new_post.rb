#!/usr/bin/env bundle exec ruby 

def usage
  puts "Usage: #{File.basename(__FILE__)} title of post"
  exit 1
end

usage if $*.empty?

require "fileutils"

drafts_root = File.join(File.dirname(__FILE__), "../views/drafts")

title    = $*.join(' ')
slug     = title.gsub(%r{\W}, "-").downcase.gsub(%r{-+}, "-").sub(%r{-$}, "")
filename = File.join(drafts_root, slug + ".html.textile")

meta = { "date" => Date.today, "title" => title }

puts "New post: #{title}"

FileUtils.mkdir_p File.dirname(filename)

File.open(filename, "w+") do |f|
  f.puts YAML.dump(meta)
  f.puts "---"
  f.puts
  f << "*Write.*"
end

system("open http://localhost:9393/drafts/#{slug}")
sleep 1
system("v #{filename}")
