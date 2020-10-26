# frozen_string_literal: true

require_relative 'lib/swags/version'

Gem::Specification.new do |spec|
  spec.name          = 'swags'
  spec.version       = Swags::VERSION
  spec.authors       = ['Валерий Маханов']
  spec.email         = ['v.mahanov@gmail.com']

  spec.summary       = 'Swags'
  spec.description   = 'Swags'
  spec.homepage      = 'https://github.com/vaallery/swags'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
