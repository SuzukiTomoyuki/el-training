# -*- encoding: utf-8 -*-
# stub: dropbox_api 0.1.11 ruby lib

Gem::Specification.new do |s|
  s.name = "dropbox_api".freeze
  s.version = "0.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jes\u00FAs Burgos".freeze]
  s.date = "2018-06-22"
  s.email = ["jburmac@gmail.com".freeze]
  s.homepage = "https://github.com/Jesus/dropbox_api".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Library for communicating with Dropbox API v2".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<oauth2>.freeze, ["~> 1.1"])
      s.add_runtime_dependency(%q<faraday>.freeze, ["~> 0.8", "~> 0.9"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<oauth2>.freeze, ["~> 1.1"])
      s.add_dependency(%q<faraday>.freeze, ["~> 0.8", "~> 0.9"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<oauth2>.freeze, ["~> 1.1"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.8", "~> 0.9"])
  end
end
