desc "Build"
task :build do
  puts "Building..."
  system "middleman build --verbose" or exit 1
end

desc "Test"
task :test do
  puts "Testing..."
  system "./scripts/link_checker.rb .build" or exit 1
  system "./scripts/test_images_in_atom_feed.rb" or exit 1
  puts "Passed!"
end

desc "Deploy to S3"
task :s3 do
  puts "Deploying to S3..."
  system "s3_website push --site=.build --headless" or exit 1
end

desc "Purge fastly"
task :purge do
  puts "Purging Fastly..."
  site_key = "MOoChSCATVIYFghwNhO7p"
  raise "Please set the FASTLY_KEY" unless key = ENV['FASTLY_KEY']
  system "curl -X POST -H 'Fastly-Key: #{key}' https://api.fastly.com/service/#{site_key}/purge_all" or exit 1
  puts
end

desc "open in browser"
task :open do
  puts "Opening in browser..."
  system("open http://tammersaleh.com") or exit 1
end

desc "build, test, deploy, purge, and open"
task publish: [:build, :test, :s3, :purge, :open]
