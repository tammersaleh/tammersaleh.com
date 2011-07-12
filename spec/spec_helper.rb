require "bundler/setup"
Bundler.require(:test)

require "#{File.dirname(__FILE__)}/../lib/tammer_saleh.rb"

Capybara.app = TammerSaleh

TammerSaleh.set     :views,  "/tmp/tammersaleh-#{$$}/views"
TammerSaleh.set     :public, "/tmp/tammersaleh-#{$$}/public"
TammerSaleh.enable  :raise_errors
TammerSaleh.disable :show_exceptions

def create_template(path, content)
  create_file "#{TammerSaleh.settings.views}/#{path}", content.unindent
end

def create_asset(path, content)
  create_file "#{TammerSaleh.settings.public}/#{path}", content.unindent
end

def create_file(path, content)
  FileUtils.mkdir_p(File.dirname(path))
  File.open(path, "w+") do |f|
    f << content
  end
end

def show_files
  pp Dir[File.join(File.dirname(TammerSaleh.settings.views), "**", "*")]
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:all) do
    FileUtils.mkdir_p(TammerSaleh.settings.views)
    FileUtils.mkdir_p(TammerSaleh.settings.public)
  end

  config.after(:all) do
    FileUtils.rm_rf(TammerSaleh.settings.views)
    FileUtils.rm_rf(TammerSaleh.settings.public)
  end

  config.before(:each) do
    FileUtils.rm_rf(TammerSaleh.settings.views)
    FileUtils.rm_rf(TammerSaleh.settings.public)
    FileUtils.mkdir_p(TammerSaleh.settings.views)
    FileUtils.mkdir_p(TammerSaleh.settings.public)
  end

  config.after(:each) do
    FileUtils.rm_rf(TammerSaleh.settings.views)
    FileUtils.rm_rf(TammerSaleh.settings.public)
    FileUtils.mkdir_p(TammerSaleh.settings.views)
    FileUtils.mkdir_p(TammerSaleh.settings.public)
  end
end

