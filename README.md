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
./test/data/regression directory. A filter can be added to ignore
lines of output (as a regex), e.g.

```ruby
  RegressionTest::CliExec::exec("ls","-l",ignore: 'INFO bio-gff3: Memory used')
```

The API doc is online. For more code examples see the test files in
the source tree. A good example can be found in the
[bio-table](https://github.com/pjotrp/bioruby-table) project which uses
cucumber features combined with the regressiontest gem. The features
look like

```ruby
Scenario: Test the numerical filter by indexed column values
  Given I have input file(s) named "test/data/input/table1.csv"
  When I execute "./bin/bio-table --num-filter 'values[3] > 0.05'"
  Then I expect the named output to match "table1-0_05"
```

and are listed in
[cli.feature](https://github.com/pjotrp/bioruby-table/blob/master/features/cli.feature)
and the matching steps are simply

```ruby
Given /^I have input file\(s\) named "(.*?)"$/ do |arg1|
  @filenames = arg1.split(/,/)
end

When /^I execute "(.*?)"$/ do |arg1|
  @cmd = arg1 + ' ' + @filenames.join(' ')
end

Then /^I expect the named output to match "(.*?)"$/ do |arg1|
  RegressionTest::CliExec::exec(@cmd,arg1).should be_true
end
```

and listed in
[cli.rb](https://github.com/pjotrp/bioruby-table/blob/master/features/step_definitions/cli-feature.rb).
The automatically generated regression output files are checked into
git in the
[test/data/regression](https://github.com/pjotrp/bioruby-table/tree/master/test/data/regression)
directory and checked with 'bundle exec rake'.
        
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

Copyright (c) 2012-2014 Pjotr Prins. See LICENSE.txt for further details.

