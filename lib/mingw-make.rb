# frozen_string_literal: true

# Set up `RUBYOPT=-I/absolute/path/to/lib/mingw-make/` for subprocesses
ENV['RUBYOPT'] = "#{ENV['RUBYOPT']} -I#{File.join __dir__, 'mingw-make'}"
ENV['MAKE'] ||= 'make'
