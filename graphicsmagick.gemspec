# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'graphicsmagick/version'

Gem::Specification.new do |gem|
  gem.name          = "graphicsmagick"
  gem.version       = GraphicsMagick::VERSION
  gem.authors       = ["Chad McGimpsey"]
  gem.email         = ["chad.mcgimpsey@gmail.com"]
  gem.description   = "Light ruby wrapper for the GraphicsMagick CLI."
  gem.summary       = "Light ruby wrapper for the GraphicsMagick CLI."
  gem.homepage      = "https://github.com/dignoe/graphicsmagick"
  gem.license       = 'MIT'

  gem.add_dependency('subexec')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
