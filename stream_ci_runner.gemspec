# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stream_ci/version'

Gem::Specification.new do |spec|
  spec.name          = 'stream-ci-runner'
  spec.version       = StreamCi::Runner::VERSION
  spec.authors       = ['James Conant']
  spec.email         = ['jconant@streamci.com']

  spec.summary       = 'StreamCI test runner'
  spec.description   = 'StreamCI test runner'
  spec.homepage      = 'https://github.com/jamesconant/stream-ci-runner'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "bin"
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rspec', '~> 3.7'
end
