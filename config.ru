require './lib/tammer_saleh'

use Rack::Static, :urls => ["/stylesheets", "/images"],
                  :root => "public"

use Rack::GoogleAnalytics, :tracker => 'UA-338217-4'

run TammerSaleh

