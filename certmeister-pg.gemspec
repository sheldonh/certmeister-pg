# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'certmeister/pg/version'

Gem::Specification.new do |spec|
  spec.name          = "certmeister-pg"
  spec.version       = Certmeister::Pg::VERSION
  spec.authors       = ["Sheldon Hearn"]
  spec.email         = ["sheldonh@starjuice.net"]
  spec.summary       = %q{PostgreSQL store for certmeister}
  spec.description   = %q{This gem provides a PostgreSQL store for use in certmeister, the conditional autosigning certificate authority.}
  spec.homepage      = "https://github.com/sheldonh/certmeister-pg"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z lib/certmeister spec/certmeister`.split("\x0").grep(/pg/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "certmeister", "~> 1.0"
  spec.add_dependency "sequel_pg", "~> 1.6"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
