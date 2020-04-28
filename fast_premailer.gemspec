# frozen_string_literal: true

require_relative 'lib/fast_premailer/version'

Gem::Specification.new do |spec|
  spec.name          = 'fast_premailer'
  spec.version       = FastPremailer::VERSION
  spec.authors       = ['Yuri Demin', 'GroupPrice dev team']
  spec.email         = ['yuri.demin@groupprice.ru']

  spec.summary       = 'groupprice projects premailer'
  spec.description   = 'Fast premailer'
  spec.homepage      = 'https://github.com/organizations/corp-gp/fast_premailer'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.files         = `git ls-files bin lib LICENSE.txt README.md`.split($RS)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'inky-rb'
  spec.add_dependency 'premailer', '~> 1.11', '>= 1.11.1'
  spec.add_dependency 'actionmailer', '>= 5'

  # spec.add_development_dependency "rubocop"
end
