
task :build do
  system "middleman build --verbose"
end

task :s3 do
  system "s3_website push --site=.build --headless"
end

task :purge do
  site_key = "MOoChSCATVIYFghwNhO7p"
  raise "Please set the FASTLY_KEY" unless key = ENV['FASTLY_KEY']
  system "curl -X POST -H 'Fastly-Key: #{key}' https://api.fastly.com/service/#{site_key}/purge_all"
  puts
end

