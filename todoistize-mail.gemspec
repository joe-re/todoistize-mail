# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'todoistize_mail/version'

Gem::Specification.new do |spec|
  spec.name          = 'todoistize-mail'
  spec.version       = TodoistizeMail::VERSION
  spec.authors       = ['joe-re']
  spec.email         = ['joe.tialtngo@gmail.com']
  spec.summary       = %q{allow you to integrate your mail into todoist.(required IMAP.)}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
end
