desc "Build"
task :build do
  puts "Building..."
  system "middleman build --verbose"
end

desc "Deploy to S3"
task :s3 do
  puts "Deploying to S3..."
  system "s3_website push --site=.build --headless"
end

desc "Purge fastly"
task :purge do
  puts "Purging Fastly..."
  site_key = "MOoChSCATVIYFghwNhO7p"
  raise "Please set the FASTLY_KEY" unless key = ENV['FASTLY_KEY']
  system "curl -X POST -H 'Fastly-Key: #{key}' https://api.fastly.com/service/#{site_key}/purge_all"
  puts
end

desc "open in browser"
task :open do
  puts "Opening in browser..."
  system("open http://tammersaleh.com")
end

desc "build, deploy, purge, and open"
task publish: [:build, :s3, :purge, :open]
