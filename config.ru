Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require 'engine_of_war'
require 'newrelic_rpm'
require "clogger"

YAML::ENGINE.yamler = 'syck' # Heroku doesn't support 'psych'

use Clogger, logger: $stdout, reentrant: true

EngineOfWar::App.set :root,        File.dirname(__FILE__)
EngineOfWar::App.set :github_info, "tsaleh/tammer-saleh"
EngineOfWar::App.set :site_title,  "Tammer Saleh"
run EngineOfWar::App

