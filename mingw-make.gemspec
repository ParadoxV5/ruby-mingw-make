# frozen_string_literal: true

Gem::Specification.new do|spec|
  spec.name = 'mingw-make'
  spec.summary = 'Patch & shim to enable Windows Ruby to install C extension gems with MinGW without MSYS2 (Devkit)'
  spec.version = '1.0.0'
  spec.author = 'ParadoxV5'
  spec.license = 'WTFPL'
  
  github_account = spec.author
  github = File.join 'https://github.com', github_account, spec.name
  spec.homepage = github
  spec.metadata = {
    'homepage_uri'      => spec.homepage,
    'source_code_uri'   => github,
    'changelog_uri'     => File.join(github, 'releases'),
    'bug_tracker_uri'   => File.join(github, 'issues'),
    'funding_uri'       => File.join('https://github.com/sponsors', github_account),
    'documentation_uri' => spec.homepage
  }

  spec.files = Dir['**/*']
  
  spec.required_ruby_version = '~> 3.1'
end
