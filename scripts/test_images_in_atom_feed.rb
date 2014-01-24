#!/usr/bin/env ruby

require "bundler"
Bundler.require

atom_content = open(".build/posts.atom")

lines_with_src = atom_content.grep(%r{src=})
paths = lines_with_src.map {|line| line.sub(%r{.*src="http://tammersaleh.com(.*)".*}, '\1').chomp }
files = paths.map {|path| File.join(".build", path)}
missing_files = files.reject {|file| File.exists?(file) }

unless missing_files.empty?
  puts "Found the following broken image links:"
  missing_files.each do |file|
    puts "  #{file}"
  end
  exit 1
end

exit 0
