# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "rack/force-status/version"

Gem::Specification.new do |s|
  s.name         = "rack-force-status"
  s.version      = Rack::ForceStatus::VERSION
  s.authors      = ["Big Cartel"]
  s.email        = "dev@bigcartel.com"
  s.homepage     = "https://github.com/bigcartel/rack-force-status"
  s.summary      = "Rack middleware for forcing status codes on responses."
  s.description  = "Rack middleware for forcing status codes on responses."

  s.files        = `git ls-files`.split($\)
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  
  s.add_dependency('rack')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
end
