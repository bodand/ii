# ii

A cross-platform command-line is-inside.me uploader

# Installation 

Installation happens by building from source. To allow easy cross-platformness,
the simple `make(1)` is used as the build system, while using Perl to cross
the remaining stuff.

## Prerequisites 

The following prerequisites are the following:

| Utility  | Extra requirements                  |
|----------|-------------------------------------|
| make     | GNU make, or any* BSD's make        |
| Compiler | Any C++17 compiler                  |
| libcurl  | A preinstalled libcurl. See [#Config](#configug) |
| perl     | Any Perl 5                          |

*: Tested with OpenBSD's `make(1)` utility. Should work with other BSD makes.

## Building

See the [#Config](#Config) section below for configuration. If the defaults are correct,
the simple `make` call will do everything. If you need to set any config macros,
just specified them after the make invocation.

## Install

The Makefile contains tooling to install stuff for the unices. For Windows,
you'll need to manually put `ii.exe` in your path, or set the install prefix.

# Config

When invoking Make, the following may be set: 

| Macro          | Meaning                                                           | Default     |
|----------------|-------------------------------------------------------------------|-------------|
| OPTIM_FLAGS    | The optimization flags to use when building                       | -Og -g      |
| CURL_LIBS      | The libraries needed to link against libcurl                      | curl        |
| CURL_INCPATH   | The include path for libcurl (none for system include paths)      |             |
| INSTALL_PREFIX | The path were to install `ii`. prefix/bin and prefix/share are used | /usr/local/ |

# Contributing 

If you wish to contribute, and feel like this program needs more meaningless extensions than what
I was able to put in, feel free to do so.
Even if you do not like it, the formatting is according to the GNU style (or at least what clang-format
calls GNU) with column-limit disabled, because other built-in formatting styles to clang-format suck ass. 
(including GNU, but that's my favourite out of them). For the smaller source footprint I do not wish to
use my usualy .clang-format file.
All contributions should be formatted with `make fmt` before creating PR-s.

# License


