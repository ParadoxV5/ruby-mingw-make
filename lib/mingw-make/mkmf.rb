# frozen_string_literal: true

require 'rbconfig'
require File.join RbConfig::CONFIG['rubylibdir'], 'mkmf'

module MakeMakefile
  # Prevent translating to MSYS `/C/some/path/` for `mingw32-make`
  def mkintpath(path) = path
end
