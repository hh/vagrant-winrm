# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib",__FILE__)
require 'vagrant-winrm/version'

Gem::Specification.new do |s|
  s.name          = "vagrant-winrm"
  s.version       = VagrantPlugins::WINRM::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Paul Morton","Chris McClimans"]
  s.homepage      = "http://github.com/hh/vagrant-winrm"
  s.email         = ["pmorton@biaprotect.com","chris@hippiehacker.org"]
  s.summary       = %q{A small gem that supports WinRM as the Communication Channel}
  s.description   = %q{Winrm Comm Support for Vagrant}

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "vagrant-winrm"

  s.add_runtime_dependency "winrm", "~> 1.1.1"
  s.add_runtime_dependency 'highline'

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec-core", "~> 2.12.2"
  s.add_development_dependency "rspec-expectations", "~> 2.12.1"
  s.add_development_dependency "rspec-mocks", "~> 2.12.1"

  # The following block of code determines the files that should be included
  # in the gem. It does this by reading all the files in the directory where
  # this gemspec is, and parsing out the ignored files from the gitignore.
  # Note that the entire gitignore(5) syntax is not supported, specifically
  # the "!" syntax, but it should mostly work correctly.
  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    # Ignore any paths that match anything in the gitignore. We do
    # two tests here:
    #
    #   - First, test to see if the entire path matches the gitignore.
    #   - Second, match if the basename does, this makes it so that things
    #     like '.DS_Store' will match sub-directories too (same behavior
    #     as git).
    #
    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end

  s.files         = unignored_files
  s.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  s.require_path  = 'lib'

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
end