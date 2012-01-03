# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'fromage/version'

Gem::Specification.new do |s|
  s.name         = "fromage"
  s.version      = Fromage::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "https://github.com/chatgris/fromage"
  s.summary      = "Role model for mongoid."
  s.description  = "Role model for mongoid."
  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_development_dependency "rspec",         "~>2.7"
  s.add_development_dependency "activesupport", "~>3.1"
  s.add_development_dependency "mongoid",       "~>2.3"
  s.add_development_dependency "bson_ext",      "~>1.5"
end
