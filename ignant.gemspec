# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ignant/version'

Gem::Specification.new do |gem|
  gem.name          = "ignant"
  gem.version       = Ignant::VERSION
  gem.authors       = ["Joel Helbling"]
  gem.email         = ["joel@joelhelbling.com"]
  gem.description   = %q{Willfully .gitignore specified files}
  gem.summary       = %q{Programmatically ensure certain files in a project are ignored by version control.  Git and SVN are supported.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.12.0'
end
