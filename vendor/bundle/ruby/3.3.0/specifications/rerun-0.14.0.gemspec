# -*- encoding: utf-8 -*-
# stub: rerun 0.14.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rerun".freeze
  s.version = "0.14.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Chaffee".freeze]
  s.date = "2023-01-04"
  s.description = "Restarts your app when a file changes. A no-frills, command-line alternative to Guard, Shotgun, Autotest, etc.".freeze
  s.email = "alexch@gmail.com".freeze
  s.executables = ["rerun".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze, "bin/rerun".freeze]
  s.homepage = "http://github.com/alexch/rerun/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.2".freeze
  s.summary = "Launches an app, and restarts it whenever the filesystem changes. A no-frills, command-line alternative to Guard, Shotgun, Autotest, etc.".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 2

  s.add_runtime_dependency(%q<listen>.freeze, ["~> 3.0".freeze])
end
