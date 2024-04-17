# frozen_string_literal: true

require 'rbconfig'

# Use `ruby -run` fall-backs 
   install   =  'ruby -run -e install -- -p'
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

require File.join RbConfig::CONFIG['rubylibdir'], 'mkmf'

module MakeMakefile
  # Prevent translating to MSYS `/C/some/path/` for `mingw32-make`
  def mkintpath(path) = path
end
