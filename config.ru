require './lib/tammer_saleh'

use Rack::Static, :urls => ["/stylesheets", "/images"],
                  :root => "public"

run TammerSaleh

