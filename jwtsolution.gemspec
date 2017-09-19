# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cli_jwt"
  s.require_paths = ["lib"]

  s.add_development_dependency "rr"
  s.add_development_dependency "guard-minitest"
  s.add_development_dependency "rake"
  s.add_runtime_dependency "thor"
end