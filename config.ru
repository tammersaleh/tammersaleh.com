Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require './lib/tammer_saleh'

use Rack::Static, :urls => ["/stylesheets", "/images"],
                  :root => "public"

run TammerSaleh

