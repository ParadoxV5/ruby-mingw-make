# frozen_string_literal: true

Gem::Specification.new do|spec|
  spec.name = 'mingw-make'
  spec.summary = 'Patches that enable Windows Ruby to install C extension gems with MinGW without MSYS2 (Devkit)'
  spec.version = '1.1.0'
  spec.author = 'ParadoxV5'
  spec.license = 'WTFPL'
  
  github_account = spec.author
  github = "https://github.com/#{github_account}/ruby-#{spec.name}"
  spec.metadata = {
    'homepage_uri'      => spec.homepage = github,
    'changelog_uri'     => File.join(github, 'releases'),
    'bug_tracker_uri'   => File.join(github, 'issues'),
    'funding_uri'       => "https://github.com/sponsors/#{github_account}"
  }

  spec.files = Dir['**/*']
  spec.executable = 'make'
  
  spec.platform = 'x64-mingw-ucrt'
  spec.required_ruby_version = '~> 3.1'
  spec.requirements = [
    'Ruby from RubyInstaller2 for Windows without DevKit (MSYS2)',
    'UCRT MinGW'
  ]
end
