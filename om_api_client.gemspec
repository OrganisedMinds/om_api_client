# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'om_api_client/version'

Gem::Specification.new do |spec|
  spec.name          = "om_api_client"
  spec.version       = OM::Api::Client::VERSION
  spec.authors       = ["Hartog C. de Mik"]
  spec.email         = ["hartog@organisedminds.com"]
  spec.description   = %q{The ruby gem for the OrganisedMinds API}
  spec.summary       = %q{OM: API client}
  spec.homepage      = "http://www.organisedminds.com/api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8.0"
  spec.add_dependency "rufus-json"
  spec.add_dependency "yajl-ruby"
  spec.add_dependency 'faraday-cookie_jar', "0.0.4"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "faker"
end
