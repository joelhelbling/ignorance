# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ignorance/version'

Gem::Specification.new do |gem|
  gem.name          = "ignorance"
  gem.version       = Ignorance::VERSION
  gem.authors       = ["Joel Helbling"]
  gem.email         = ["joel@joelhelbling.com"]
  gem.description   = %q{Ensures specified files are ignored by Git, Mercurial or SVN.}
  gem.summary       = %q{Ignorance helps your code be considerate of its users by protecting sensitive information from version control.}
  gem.homepage      = "http://github.com/joelhelbling/ignorance"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'highline', '~> 1.6.15'

  gem.add_development_dependency 'rspec',   '~> 2.12.0'
  gem.add_development_dependency 'fakefs',  '~> 0.4.2'
  gem.add_development_dependency 'rake',    '10.0.3'
  gem.add_development_dependency 'pry',     '~> 0.9.11.4'
end
