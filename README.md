# regressiontest

[![Build Status](https://secure.travis-ci.org/pjotrp/regressiontest.png)](http://travis-ci.org/pjotrp/regressiontest)

regressiontest, at this point, is a simple module for calling programs
on the command line, capturing output and comparing output against an
existing reference file. The idea is to capture changes in output at a
very global level, perhaps with different input files and command line
options.

Note that JRuby on Travis does not allow invoking the command line,
but MRI and Rubinius work fine.

Note: this software is under active development, your mileage may vary!

## Installation

```sh
    gem install regressiontest
```

## Usage

```ruby
    require 'regressiontest'
```

Simple usage

```ruby
  RegressionTest::CliExec::exec("ls","-l").should be_true
```

by default a .ref and a .new file are created in the 
./test/data/regression directory.

The API doc is online. For more code examples see the test files in
the source tree.
        
## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/pjotrp/regressiontest

The BioRuby community is on IRC server: irc.freenode.org, channel: #bioruby.

## Cite

If you use this software, please cite one of
  
* [BioRuby: bioinformatics software for the Ruby programming language](http://dx.doi.org/10.1093/bioinformatics/btq475)
* [Biogem: an effective tool-based approach for scaling up open source software development in bioinformatics](http://dx.doi.org/10.1093/bioinformatics/bts080)

## Biogems.info

This Biogem is published at [#regressiontest](http://biogems.info/index.html)

## Copyright

Copyright (c) 2012 Pjotr Prins. See LICENSE.txt for further details.

