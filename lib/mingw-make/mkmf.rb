# frozen_string_literal: true

require 'rbconfig'

# Get `mkmf` to fall back to `ruby -run` 
%w[
  RM
  RMALL
  RMDIRS
  MAKEDIRS
  INSTALL
  INSTALL_PROG
  INSTALL_DATA
  CP
].each do|key|
  RbConfig::CONFIG.delete key
  RbConfig::MAKEFILE_CONFIG.delete key
end

require File.join RbConfig::CONFIG['rubylibdir'], 'mkmf'

module MakeMakefile
  # Prevent translating to MSYS `/C/some/path/` for `mingw32-make`
  def mkintpath(path) = path
end
