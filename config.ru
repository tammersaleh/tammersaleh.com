# require 'rubygems'
# require 'middleman/rack'
# 
# run Middleman.server

require 'rubygems'
require 'middleman/rack'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'
require 'rack/timeout'
# require "./lib/rack/custom_error_pages.rb"

use Rack::Timeout
Rack::Timeout.timeout = 10

# use Rack::CustomErrorPages, "build/500.html"
use Rack::TryStatic, :root => "build", :urls => %w[/], :try => ['.html', "index.html", "/index.html"]
run Middleman.server
#run Rack::NotFound.new("build/404.html")

