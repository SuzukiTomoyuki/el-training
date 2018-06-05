# -*- encoding: utf-8 -*-
# stub: bootstrap-multiselect-rails 0.9.9 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap-multiselect-rails".freeze
  s.version = "0.9.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Benjamin Canac".freeze]
  s.date = "2014-10-09"
  s.description = "Add Bootstrap Multiselect v0.9.9 to your rails app. See https://github.com/davidstutz/bootstrap-multiselect for more information about bootstrap-multiselect.".freeze
  s.email = ["canacb1@gmail.com".freeze]
  s.homepage = "https://github.com/benjamincanac/bootstrap-multiselect-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Add Bootstrap Multiselect v0.9.9 to your rails app.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 4.0.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 4.0.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 4.0.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
