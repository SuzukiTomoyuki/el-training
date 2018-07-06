# -*- encoding: utf-8 -*-
# stub: dropbox-sdk-v2 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "dropbox-sdk-v2".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dylan Waits".freeze]
  s.date = "2016-07-02"
  s.description = "A Ruby library for the new Dropbox API.".freeze
  s.email = "dylan@waits.io".freeze
  s.homepage = "https://github.com/waits/dropbox-sdk-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Dropbox SDK v2".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_runtime_dependency(%q<http>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
      s.add_dependency(%q<http>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
    s.add_dependency(%q<http>.freeze, ["~> 2.0"])
  end
end
