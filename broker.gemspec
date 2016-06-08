$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "broker/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bigbluebutton-rails_broker"
  s.version     = Broker::VERSION
  s.authors     = ["blindsidenetworks"]
  s.email       = ["support@blindsidenetworks"]
  s.homepage    = "https://github.com/blindsidenetworks/bigbluebutton-rails_broker"
  s.summary     = "A Rails mountable engine for managing BigBlueButton requests in a Rails app."
  s.description = "A Rails mountable engine that implements a layer for dealing with requests to a bbb server from a js enabled UI."
  s.license     = "LGPL"

  s.files = Dir["{app,config,db,lib}/**/*", "LGPL-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency "bigbluebutton-api-ruby", "~> 1.5.0"

  s.add_development_dependency "sqlite3"
end
