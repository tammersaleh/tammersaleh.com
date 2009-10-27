# From http://blog.madeofcode.com/post/194902314/generate-gem-yml-and-gems-for-rails

namespace :gems do
  desc "Generate .gems file for Heroku"
  task :heroku_spec => :environment do
		require 'open-uri'
		installed_gems = []
		open("http://installed-gems.heroku.com/").read.scan(/<li>(\w+) [^<]*<\/li>/) do |w| 
			installed_gems << w.first
		end

    gems = Rails.configuration.gems
    
    # output .gems
    dot_gems = File.join(RAILS_ROOT, ".gems")
    File.open(dot_gems, "w") do |f|
      output = []
      gems.each do |gem|
				next if installed_gems.include?(gem.name)
        spec = "#{gem.name} --version '#{gem.version_requirements.to_s}'"
        spec << " --source #{gem.source}" if gem.source
        output << spec
      end
      f.write output.join("\n")
      puts output.join("\n")
    end
  end
end
