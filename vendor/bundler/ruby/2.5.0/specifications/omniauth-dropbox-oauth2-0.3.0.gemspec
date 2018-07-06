# -*- encoding: utf-8 -*-
# stub: omniauth-dropbox-oauth2 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-dropbox-oauth2".freeze
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bernardo Amorim".freeze]
  s.date = "2015-11-24"
  s.description = "Dropbox OAuth2 strategy for OmniAuth 1.x".freeze
  s.email = "contato@bamorim.com".freeze
  s.homepage = "https://github.com/bamorim/omniauth-dropbox-oauth2".freeze
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Dropbox OAuth2 strategy for OmniAuth 1.x".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.3.1"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.3.1"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.3.1"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
