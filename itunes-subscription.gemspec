# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itunes-subscription/version'

Gem::Specification.new do |s|
  s.name          = "itunes-subscription"
  s.version       = ItunesSubscription::VERSION
  s.authors       = ["Stepan Habor"]
  s.email         = ["gabor_96@mail.ru"]

  s.summary       = "Ruby wrapper for iTunes Subscription."
  s.description   = "Ruby wrapper for iTunes Subscription"
  s.homepage      = "https://github.com/SHabor/itunes-subscription"
  s.license       = "MIT"

  s.files         = [
      "Gemfile",
      "Gemfile.lock",
      "LICENSE.txt",
      "README.md",
      "Rakefile",
      "lib/itunes-subscription.rb",
      "lib/itunes-subscription/version.rb"
  ]

  s.require_paths = ["lib"]
  s.add_dependency "rest-client"
end
