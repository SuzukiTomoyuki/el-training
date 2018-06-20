# -*- encoding: utf-8 -*-
# stub: capistrano 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "capistrano".freeze
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tom Clements".freeze, "Lee Hambley".freeze]
  s.date = "2013-11-02"
  s.description = "Capistrano is a utility and framework for executing commands in parallel on multiple remote machines, via SSH.".freeze
  s.email = ["seenmyfate@gmail.com".freeze, "lee.hambley@gmail.com".freeze]
  s.executables = ["cap".freeze, "capify".freeze]
  s.files = ["bin/cap".freeze, "bin/capify".freeze]
  s.homepage = "http://capistranorb.com/".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "If you're updating Capistrano from 2.x.x, we recommend you to read the upgrade guide: http://www.capistranorb.com/documentation/upgrading/".freeze
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Capistrano - Welcome to easy deployment with Ruby over SSH".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sshkit>.freeze, [">= 0.0.23"])
      s.add_runtime_dependency(%q<rake>.freeze, [">= 10.0.0"])
      s.add_runtime_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<vagrant>.freeze, ["~> 1.0.7"])
      s.add_development_dependency(%q<kuroko>.freeze, [">= 0"])
      s.add_development_dependency(%q<cucumber>.freeze, [">= 0"])
    else
      s.add_dependency(%q<sshkit>.freeze, [">= 0.0.23"])
      s.add_dependency(%q<rake>.freeze, [">= 10.0.0"])
      s.add_dependency(%q<i18n>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<vagrant>.freeze, ["~> 1.0.7"])
      s.add_dependency(%q<kuroko>.freeze, [">= 0"])
      s.add_dependency(%q<cucumber>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<sshkit>.freeze, [">= 0.0.23"])
    s.add_dependency(%q<rake>.freeze, [">= 10.0.0"])
    s.add_dependency(%q<i18n>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<vagrant>.freeze, ["~> 1.0.7"])
    s.add_dependency(%q<kuroko>.freeze, [">= 0"])
    s.add_dependency(%q<cucumber>.freeze, [">= 0"])
  end
end
