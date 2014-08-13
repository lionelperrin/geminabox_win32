# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geminabox_win32/version'

Gem::Specification.new do |spec|
  spec.name          = "geminabox_win32"
  spec.version       = GeminaboxWin32::VERSION
  spec.authors       = ["Lionel Perrin"]
  spec.email         = ["lionel.perrin@moodys.com"]
  spec.summary       = %q{Windows service for geminabox server.}
  spec.homepage      = ""

  spec.files         = Dir['lib/**/*'] + Dir['bin/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "geminabox"
  spec.add_runtime_dependency "win32-service"
end
