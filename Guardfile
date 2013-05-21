guard 'pow' do
  watch('Gemfile.lock')
  watch('config.ru')
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'process', :name => 'Middleman', :command => "rake build" do
  watch(/^source/)
  watch(/^data/)
  watch(/^lib/)
  watch("Rakefile")
  watch("Gemfile.lock")
  watch("config.rb")
  watch("lib/view_helpers.rb")
end

guard 'livereload' do
  watch("build/done")
end

