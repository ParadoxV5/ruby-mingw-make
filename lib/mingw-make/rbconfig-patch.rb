# frozen_string_literal: true

# Normally, RubyGems `require`s `rbconfig` itself, so overloading `require 'rbconfig'` may be ineffective.
# Howëver, if RubyGems are disabled (`--disable-gems`), nameing this file `rbconfig.rb` would conflict with the design,
# which depends on the original {RbConfig} to bypass the modified `$LOAD_PATH` to fetch the original {MakeMakefile}.

require 'rbconfig'

# Use `ruby -run` fall-backs 
install      =  'ruby -run -e install -- -p'
fixed = {
  'RM'       => 'ruby -run -e rm -- -f',
  'RMALL'    => 'ruby -run -e rm -- -rf',
  'RMDIRS'   => 'ruby -run -e rmdir -- -p',
  'MAKEDIRS' => 'ruby -run -e mkdir -- -p',
  'CP'       => 'ruby -run -e cp --',
  'INSTALL'  => install
}
install_args = {
  'INSTALL_PROG' => '-m 0755',
  'INSTALL_DATA' => '-m 0644'
}
RbConfig::MAKEFILE_CONFIG.merge! fixed, install_args.transform_values { "$(INSTALL) #{_1}" }
RbConfig::CONFIG.merge!          fixed, install_args.transform_values { "#{install} #{_1}" }
