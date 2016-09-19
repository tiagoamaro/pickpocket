# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pickpocket/version'

Gem::Specification.new do |spec|
  spec.name          = "pickpocket"
  spec.version       = Pickpocket::VERSION
  spec.authors       = ["Tiago Amaro"]
  spec.email         = ["tiagopadrela@gmail.com"]

  spec.summary       = %q{Pickpocket: selects a random article from your Pocket (former Read It Later)}
  spec.description   = %q{Pickpocket: selects a random article from your Pocket (former Read It Later)}
  spec.homepage      = "https://github.com/tiagoamaro/pickpocket"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "pickpocket"
  spec.require_paths = ["lib"]

  spec.add_dependency "launchy", "~> 2.4.3"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0.3"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6.0"
  spec.add_development_dependency "webmock", "~> 2.1.0"
end
