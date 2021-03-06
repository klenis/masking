# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'masking/version'

Gem::Specification.new do |spec|
  spec.name          = 'masking'
  spec.version       = Masking::VERSION
  spec.authors       = ['Chikahiro Tokoro']
  spec.email         = ['uzukifirst@gmail.com']

  spec.summary       = 'Command line tool for anonymizing databese records'
  spec.description   = 'Command line tool for anonymizing database records by parsing a SQL dump file and ' \
                       'build new SQL dump file with masking sensitive/credential data.'
  spec.homepage      = 'https://github.com/kibitan/masking'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rake-notes'
  spec.add_development_dependency 'ruby-prof'

  # linter/static analyzer
  spec.add_development_dependency 'mdl'
  spec.add_development_dependency 'rubocop'

  # test
  spec.add_development_dependency 'codecov'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'

  # debug
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'tapp'
end
