# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bumbleworks/api/version'

Gem::Specification.new do |spec|
  spec.name          = "bumbleworks-api"
  spec.version       = Bumbleworks::Api::VERSION
  spec.authors       = ["Ravi Gadad"]
  spec.email         = ["ravi@renewfund.com"]
  spec.description   = %q{Bumbleworks JSON API}
  spec.summary       = %q{This gem implements a headless Rory application (mountable in your own app)
                          for interacting with a Bumbleworks instance.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "bumbleworks", ">= 0.0.91"
  spec.add_runtime_dependency "rory", ">= 0.5.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'shotgun'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'pry'
end
