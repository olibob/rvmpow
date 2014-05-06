# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rvmpow/version'

Gem::Specification.new do |spec|
  spec.name          = "rvmpow"
  spec.version       = RvmPow::VERSION
  spec.authors       = ["Olivier Robert"]
  spec.email         = ["robby57@gmail.com"]
  spec.summary       = %q{Sets up pow (http://pow.cx/) for your rake app}
  spec.description   = %q{Pow (http://pow.cx) needs to know what ruby and gemset is being used. rvm users can provide this information manually (http://rvm.io/integration/pow) or install `rvmpow` and it'll handle it for you, including adding the new configuration file to .gitignore and linking the new app for immediate browsing.}
  spec.homepage      = "https://github.com/olibob/rvmpow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
end
