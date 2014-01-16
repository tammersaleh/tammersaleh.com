#!/usr/bin/env ruby

require 'bundler'
Bundler.require

$ret = 0

def process(build_root, file)
  URLs.get_urls_from(build_root, file).each do |url|
    if url.file_exists?
      process(build_root, url.to_filename)
    else
      puts "MISSING: #{file} points to #{url}" 
      $ret = 1
    end
  end
end

class String
  def starts_with?(s)
    self[0, s.length] == s.to_s
  end

  def ends_with?(s)
    self[-1, s.length] == s.to_s
  end
end

class URL < Struct.new(:build_root, :url_base, :url)
  def relative?
    not url.starts_with?("/")
  end

  def local?
    not (url["://"] or url.starts_with?("mailto:"))
  end

  def directory?
    url.ends_with?("/")
  end

  def root?
    url == "/"
  end

  def clean
    self.class.new(build_root, url_base, url.split("?")[0])
  end

  def file_exists?
    File.exists?(to_filename)
  end

  def to_filename
    path = url
    path = File.join(path, "index.html") if directory?
    path = File.join(url_base, path)     if relative?
    path = File.join(build_root, path)
    return path
  end

  def to_s
    url
  end
end

class URLs
  def self.get_urls_from(build_root, path)
    new_from_file(build_root, path).to_a
  end

  def self.new_from_file(build_root, path)
    url = path.gsub(build_root, "")
    url_base = File.dirname(url)
    doc = Nokogiri::XML(open(path))
    links = doc.css("a").map   { |link| URL.new(build_root, url_base, link[:href]) }
    imgs  = doc.css("img").map { |link| URL.new(build_root, url_base, link[:src] ) }
    return new(links + imgs)
  end

  def initialize(urls)
    @urls = urls
    @urls.reject! {|u| u.root? }
    @urls.select! {|u| u.local? }
    @urls.map!    {|u| u.clean }
  end

  def to_a
    @urls.dup
  end
end

root = ARGV[0]
index_html = File.join(root, "index.html")

process(root, index_html)

exit $ret
