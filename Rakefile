require 'bundler'
Bundler.require

desc "Build the website from source"
task :build do
  system("middleman build") or puts "FAILED"
  system("touch build/done")
end

desc "Open the site in your browser (assumes pow)"
task :open do
  system("open http://tammersaleh.dev") or puts "FAILED"
end

desc "Smush images"
task :smush do
  system("smusher #{File.dirname(__FILE__)}/source/images") or puts "FAILED"
end

task default: [:build, :open]

