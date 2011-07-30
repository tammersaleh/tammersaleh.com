#!/usr/bin/env bundle exec ruby 

require "sequel"
require "mysql"
require "fileutils"
require "yaml"

posts_root = "views/posts"

Sequel.connect(:adapter=>'mysql', :host=>'localhost', :database=>'tammer_saleh_development', :user=>'root') do |db|
  db[:posts].all do |post|
    date     = post[:published_at]
    title    = post[:title]
    slug     = post[:slug]
    body     = post[:body]
    extended = post[:extended]

    filename = "#{posts_root}/#{slug}.textile"
    puts filename

    meta = {
      "date"  => (date && date.to_date),
      "title" => title,
    }

    File.open(filename, "w+") do |f|
      f.puts YAML.dump(meta)
      f.puts "---"
      f.puts
      f << body
      f.puts
      f << extended
    end
  end
end

