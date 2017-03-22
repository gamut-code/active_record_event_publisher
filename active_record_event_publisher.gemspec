$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_record_event_publisher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_event_publisher"
  s.version     = ActiveRecordEventPublisher::VERSION
  s.authors     = ["Darby Frey"]
  s.email       = ["darby.frey@gamut.com"]
  s.homepage    = "https://github.com/gamut-code/active_record_event_publisher"
  s.summary     = "Publishes data change events from ActiveRecord to SQS"
  s.description = "Publishes data change events from ActiveRecord to SQS"
  s.license     = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
