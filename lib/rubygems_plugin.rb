# frozen_string_literal: true

# Note:
# RubyInstaller2’s `rubygems/defaults/operating_system.rb`
# loads before this file, patch it immediately.
begin
  require 'ruby_installer/runtime/msys2_installation'
rescue LoadError
  # ignore
else
  # Skip check MSYS2 when installing gems
  class RubyInstaller::Runtime::Msys2Installation
    alias _original_ruby_installer__enable_msys_apps enable_msys_apps
    def enable_msys_apps(for_gem_install: nil, **kwargs)
      _original_ruby_installer__enable_msys_apps(for_gem_install:, **kwargs) unless for_gem_install
    end
  end
end

# Set up `RUBYOPT=-I/absolute/path/to/lib/mingw-make/` for subprocesses
Gem.pre_install do
  ENV['RUBYOPT'] = "#{ENV['RUBYOPT']} -I#{File.join __dir__, 'mingw-make'}"
end
