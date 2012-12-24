# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'fromage/version'

Gem::Specification.new do |s|
  s.name         = "fromage"
  s.version      = Fromage::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "http://chatgris.github.com/fromage"
  s.summary      = "Role model for mongoid."
  s.description  = "Role model for mongoid."
  s.files        = `git ls-files LICENSE README.md lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_development_dependency "rspec"
  s.add_development_dependency "mongoid"
end
