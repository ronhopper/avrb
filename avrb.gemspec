# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib/", __FILE__)
$:.unshift lib unless $:.include?(lib)

require "avrb/version"

Gem::Specification.new do |s|
  s.name         = "avrb"
  s.version      = AVRB::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Ron Hopper"]
  s.email        = ["rchopper@gmail.com"]
  s.homepage     = "http://github.com/ronhopper/avrb"
  s.summary      = "AVR assembler."
  s.files        = Dir.glob("{bin,lib,spec}/**/*")
  s.test_files   = Dir.glob("spec/**/*")
  s.require_path = "lib"
  s.executables  = ["avrb"]

  s.add_development_dependency "rspec", "~> 2.12"
end

