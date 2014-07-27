# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "jekyll-autolink_email"
  spec.version       = "0.0.2"
  spec.authors       = ["Ivan Tse"]
  spec.email         = ["ivan.tse1@gmail.com"]
  spec.summary       = "Autolink emails for your Jekyll site."
  spec.description   = ""
  spec.homepage      = "https://github.com/ivantsepp/jekyll-autolink_email"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", '~> 2.0'
  spec.add_dependency "rinku", '~> 1.7.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "shoulda"
  spec.add_development_dependency "mocha"
end
