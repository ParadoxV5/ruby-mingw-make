# frozen_string_literal: true

# Set up `RUBYOPT=-I/absolute/path/to/lib/mingw-make/` for subprocesses
Gem.pre_install do
  ENV['RUBYOPT'] = "#{ENV['RUBYOPT']} -I#{File.join __dir__, 'mingw-make'}"
end
