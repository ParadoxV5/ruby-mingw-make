When it comes to C-based extension Ruby gems on Windows,
the status quo depends on the heavyweight [MSYS2](https://www.msys2.org) to build and install them.
However, [__Minimum__ GNU for Windows (MinGW)](https://github.com/niXman/mingw-builds-binaries/releases),
a key component of MSYS2, is sufficient for half of the jobs all on its own.

`mingw-make` is a set of tiny non-intrusive mods for [RubyInstaller2 for Windows](https://rubyinstaller.org)
that solves the hurdles on the other half minimally, namely by replacing `rbconfig` entries of compilation commands.
With the aid of the secret [`ruby -run`](https://github.com/ruby/un) capability it has unleashed,
all it took was a couple of quick hacks and we have ourselves a lightweight Devkit.

Setups with MinGW and RubyInstaller’s prebuilds with these patches are ideal to keep footprints small,
though experts strongly recommend WSL for a fully-fledged Ruby environment.

### Compatibility

I’m glad to announce that, except for Prism for which I have sent PRs,
**this experiment works with `gem update` versions of every [Default and Bundled C extension](https://stdgems.org) 📈**.

While I have only tested this experiment with the following projects,
In theory, it’s compatible with anything that doesn’t leave
[`rbconfig`](https://rubyapi.org/o/RbConfig)+[`mkmf`](https://rubyapi.org/o/MakeMakefile)’s comfort zone,
which I expect to be the majority of C-based gems. (It *will indeed* “take a while” when “Building native extensions”.)
Please do [let me know](https://github.com/ParadoxV5/ruby-mingw-make/issues)
if it doesn’t meet the expectations on something not unusual.

#### builds

* `bigdecimal 3.1.6..3.1.8`
* `json 2.7.2`
* `io-console 0.7.2`
* `nkf 0.2.0`
* [`prism 9bb8710`](https://github.com/ruby/prism/pull/2711)
* `strscan 3.1.0`
* `debug 1.9.2`
* `racc 1.7.3..1.8.0`
* `rbs 3.4.4`

#### fails
* `prism ..0.29.0`:
  > * It must be possible to build prism without needing ruby/rake/etc.
  >   Because once prism is the single parser in TruffleRuby, JRuby or CRuby there won't be another Ruby parser around to parse such Ruby code.
  >   \[…]
  > 
  > The main solution for the second point seems a Makefile, otherwise many of the usages would have to duplicate the logic to build prism.
  > 
  > ⸺ https://github.com/ruby/prism/blob/19c67fb/docs/build_system.md#requirements
* `ffi` (the platform-agnostic edition; though Ruby should auto-prefer [the fat binary gem](https://rubygems.org/gems/ffi/versions/1.17.0.rc2-x64-mingw-ucrt) instead)

### not thoroughly tested
* `syslog 0.1.2`: [It’s UNIX-specific.](https://stackoverflow.com/a/9503254)
* `readline-ext 0.2.0`: ``extconf.rb:64:in `<main>': Neither readline nor libedit was found (RuntimeError)``


## Setup

### Requirements
* Windows
  * Linux need MinGW not.
* Ruby from RubyInstaller2 without DevKit (MSYS2)
  * Does it work with other Rubies? Well… maybe?
* MinGW for the Universal C Runtime (UCRT), with the `bin`aries folder on the `PATH`
  * Will it work with MSYS? Uhh… likely not.

### Installation
```sh
gem install mingw-make
```

### Use with `gem`

Thanks to `gem`’s [plugins](https://guides.rubygems.org/plugins/) system, it’s online out of the box!

### Use with [`rake-compiler`](https://github.com/rake-compiler/rake-compiler)

Slap this somewhere in the `Rakefile`:
```ruby
begin
  require 'mingw-make'
rescue LoadError
  # ignore
end
```

### Use manually
*Prepend* (so it takes precedence) the [`lib/mingw-make/mkmf.rb`](lib/mingw-make/mkmf.rb)
script to the Ruby `$LOAD_PATH`. Because RubyGems `require 'rbconfig'`,
we must explicitly apply [the `rbconfig` replacements](lib/mingw-make/rbconfig-patch.rb).
```bat
set RUBYOPT=-Ipath/to/gems/mingw-make/lib/mingw-make/ -rrbconfig-patch
```
You may also need to specify a fallback for the `MAKE` tool, e.g.:
```bat
set MAKE=mingw32-make
```


## How to Contribute

Ackchyually – I would much prefer you **don’t**, but instead forward my tinkering to their corresponding upstreams.
Windows users like me would love if our chérie lang doesn’t require more (WSL) or less (MSYS) a Linux Virtual Machine.
(Imagine… Ruby VM in a Linux VM in a Windows VM… 🫠)
After all, the [WTFPL](LICENSE.txt) means that I’ve decided to release my knowledge to the public domain,
so no need to thank me and go bring developer happiness to its next level!
