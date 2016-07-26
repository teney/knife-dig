# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "knife-dig/version"

Gem::Specification.new do |s|
  s.name          = 'knife-dig'
  s.version       = Knife::Dig::VERSION
  s.date          = '2016-07-26'
  s.summary       = "A plugin for Chef::Knife which displays recursively displays the run list of a role."
  s.description   = s.summary
  s.authors       = ["Frank Teney"]
  s.email         = ["frank.teney@gmail.com"]
  s.homepage      = "https://github.com/teney/knife-dig"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
