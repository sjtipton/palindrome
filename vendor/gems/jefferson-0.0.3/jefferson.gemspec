# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jefferson/version'

Gem::Specification.new do |gem|
  gem.name          = "jefferson"
  gem.version       = Jefferson::VERSION
  gem.authors       = ["Steve Tipton", "Jeff Self"]
  gem.email         = ["steve.tipton@employmentguide.com",
                       "jeff.self@employmentguide.com"]
  gem.description   = %q{REST API client gem for accessing Learning Registry resources}
  gem.summary       = %q{REST API client gem for accessing Learning Registry resources}
  gem.homepage      = ""

  gem.add_dependency(%q<rake>, ">= 0")
  gem.add_dependency(%q<typhoeus>, '~> 0.3.3')
  gem.add_dependency(%q<yajl-ruby>, ">= 0")
  gem.add_dependency('activesupport')
  gem.add_dependency('activemodel')
  gem.add_dependency('activeresource')
  gem.add_dependency(%q<sanitize>, ">= 0")

  gem.add_development_dependency('awesome_print')
  gem.add_development_dependency('interactive_editor')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = Jefferson::VERSION
end
