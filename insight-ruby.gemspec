# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'insight/version'

Gem::Specification.new do |spec|
  spec.name          = 'insight_bitpay'
  spec.version       = Insight::VERSION
  spec.authors       = ['Genaro Madrid, Francesco "makevoid" Canessa']
  spec.email         = ['genmadrid@gmail.com, makevoid@gmail.com']
  spec.summary       = %q{Ruby SDK for insight.bitpay.com}
  spec.description   = %q{Ruby SDK for insight.bitpay.com API - makevoid's fork}
  spec.homepage      = 'https://github.com/makevoid/insight-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rest-client', '~> 1.7'
  spec.add_runtime_dependency 'json', '~> 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '3.1.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.0'
  spec.add_development_dependency 'bump', '~> 0.5', '>= 0.5.3'
end
