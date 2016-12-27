require File.expand_path("../lib/true_url/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "true_url"
  spec.version       = TrueURL::VERSION
  spec.authors       = ["Jonathan Wong"]
  spec.email         = ["jonathan@armchairtheorist.com"]
  spec.summary       = "A multi-strategy approach to derive the absolutely cleanest canonical URL of any given URL."
  spec.homepage      = "http://github.com/armchairtheorist/true_url"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {spec}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rspec', '~> 0'
  spec.add_development_dependency 'rake', '~> 0'
end