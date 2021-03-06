# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "twizo/version"

Gem::Specification.new do |spec|
  spec.name          = "twizo"
  spec.version       = Twizo::VERSION
  spec.date          = "2018-06-13"
  spec.authors       = ["Arjen Heijkoop"]
  spec.email         = ["support@twizo.com"]

  spec.summary       = %q{Connect to the Twizo API using the Ruby library.}
  spec.description   = %q{Connect to the Twizo API using the Ruby library.}
  spec.homepage      = "https://github.com/twizoapi/lib-api-ruby"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.4'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = ""
  # else
  #   raise "RubyGems 2.4 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^test|spec|features})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.2"
  spec.add_development_dependency "mocha", "~> 1.3"
end
