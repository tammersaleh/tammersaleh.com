# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'middleman', verbose: true do
  watch(%r{^config.rb})
  watch(%r{^data/.*})
  watch(%r{^source/.*})
  watch("Gemfile.lock")
end

guard :bundler do
  watch('Gemfile')
end

guard 'livereload', grace_period: 0.5 do
  watch(%r{.build/.*})
end
