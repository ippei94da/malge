# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "malge"
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ippei94da"]
  s.date = "2013-03-18"
  s.description = "Mathematical library to deal with basic problems in algebla.\n  "
  s.email = "ippei94da@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "CHANGES",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/malge.rb",
    "lib/malge/errorfittedfunction.rb",
    "lib/malge/errorfittedfunction/aexpbx.rb",
    "lib/malge/errorfittedfunction/aexpbx32.rb",
    "lib/malge/errorfittedfunction/axinv.rb",
    "lib/malge/errorfittedfunction/axinv2.rb",
    "lib/malge/errorfittedfunction/axinv3.rb",
    "lib/malge/errorfittedfunction/axinv32.rb",
    "lib/malge/leastsquare.rb",
    "lib/malge/matrix.rb",
    "lib/malge/simultaneousequations.rb",
    "lib/malge/vector.rb",
    "malge.gemspec",
    "test/helper.rb",
    "test/test_errorfittedfunction.rb",
    "test/test_errorfittedfunction_aexpbx.rb",
    "test/test_errorfittedfunction_aexpbx32.rb",
    "test/test_errorfittedfunction_axinv.rb",
    "test/test_errorfittedfunction_axinv2.rb",
    "test/test_errorfittedfunction_axinv3.rb",
    "test/test_errorfittedfunction_axinv32.rb",
    "test/test_leastsquare.rb",
    "test/test_simultaneousequations.rb"
  ]
  s.homepage = "http://github.com/ippei94da/malge"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Math ALGEbra library."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.2"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2.2"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2.2"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

