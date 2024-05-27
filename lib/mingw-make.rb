# frozen_string_literal: true

# Set up `RUBYOPT=-I/absolute/path/to/lib/mingw-make/ -rrbconfig-patch` for subprocesses
ENV['RUBYOPT'] = "#{ENV['RUBYOPT']} -I#{File.join __dir__, 'mingw-make'} -rrbconfig-patch"
ENV['MAKE'] ||= 'make'
