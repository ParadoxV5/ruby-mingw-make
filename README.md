When it comes to C-based extension Ruby gems on Windows,
the status quo depends on the heavyweight [MSYS2](https://www.msys2.org) to build and install them.
However, [__Minimum__ GNU for Windows (MinGW)](https://github.com/niXman/mingw-builds-binaries/releases),
a key component of MSYS2, is sufficient for half of the jobs all on its own.

`mingw-make` is a set of tiny non-intrusive mods for [RubyInstaller2 for Windows](https://rubyinstaller.org)
that solves the hurdles on the other half minimally.
With the aid of the secret [`ruby -run`](https://github.com/ruby/un) capability it has unleashed,
all it took was a couple of quick hacks and we have ourselves a lightweight Devkit.

Setups with MinGW and RubyInstaller’s prebuilds with these patches are ideal to keep footprints small,
for experts strongly recommend WSL for a fully-fledged Ruby environment.

This project is a newly published experiment, and I have only tested with `bigdecimal-3.1.6`. In theory,
it’s compatible with anything that doesn’t leave [`mkmf`](https://rubyapi.org/o/MakeMakefile)’s comfort zone.
(It also *will indeed* “take a while” when “Building native extensions”.)
Please do [let me know](https://github.com/ParadoxV5/ruby-mingw-make/issues)
if it doesn’t meet the expectations on something not unusual.


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


## Usage

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
Specify `mingw32-make` as the `MAKE` tool and prepend the `lib/mingw-make/mkmf.rb` script to the Ruby `$LOAD_PATH`.
```bat
set MAKE=mingw32-make
set RUBYOPT=-Ipath/to/gems/mingw-make/lib/mingw-make/
```


## How to Contribute

Ackchyually – I would much prefer you **don’t**, but instead forward my tinkering to their corresponding upstreams.
Windows users like me would love if our chérie lang doesn’t require more (WSL) or less (MSYS) a Linux Virtual Machine.
(Imagine… Ruby VM in a Linux VM in a Windows VM… 🫠)
After all, the [WTFPL](LICENSE.txt) means that I’ve decided to release my knowledge to the public domain,
so no need to thank me and go bring developer happiness to its next level!
