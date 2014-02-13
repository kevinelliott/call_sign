# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'call_sign/version'

Gem::Specification.new do |spec|
  spec.name          = "call_sign"
  spec.version       = CallSign::VERSION
  spec.authors       = ["Kevin Elliott"]
  spec.email         = ["kevin@welikeinc.com"]
  spec.summary       = %q{Handle and process ITU Call Signs}
  spec.description   = %q{Handle and process ITU Call Signs}
  spec.homepage      = "http://github.com/kevinelliott/call_sign"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
