# encoding: utf-8
path = File.expand_path(File.dirname(__FILE__) + '/../lib/')
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'mongoid/fromage'

Mongoid.configure do |config|
    config.connect_to('fromage_spec', consistency: :strong)
end

RSpec.configure do |config|
  config.after :each do
    Mongoid.purge!
  end
end
