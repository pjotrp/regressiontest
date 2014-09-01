require 'fileutils'

module RegressionTest

  DEFAULT_TESTDIR = "test/data/regression"

  # Regression test runner compares output in ./test/data/regression (by default).
  # The convention is to have a file with names .ref (reference) and create .new
  #
  # You can add an :ignore regex option which ignores lines in the comparson files 
  # matching a regex
  module CliExec
    def CliExec::exec command, testname, options = {}
      # ---- Find .ref file
      fullname = DEFAULT_TESTDIR + "/" + testname 
      basefn = if File.exist?(testname+".ref")
                testname 
              elsif fullname + ".ref"
                FileUtils.mkdir_p DEFAULT_TESTDIR
                fullname
              else
                raise "Can not find reference file for #{testname} - expected #{fullname}.ref"
              end
      outfn = basefn + ".new"
      reffn = basefn + ".ref"
      # ---- Create .new file
      cmd = command + " > #{outfn}"
      $stderr.print cmd,"\n"
      if Kernel.system(cmd) == false
        $stderr.print cmd," returned an error\n"
        return false 
      end
      if options[:ignore]
        regex = options[:ignore]
        outfn1 = outfn + ".1"
        FileUtils.mv(outfn,outfn1)
        buf = []
        f1 = File.open(outfn1)
        f = File.open(outfn,"w")
        f1.each_line do | line |
          f.print(line) if line !~ /#{regex}/
        end
        f1.close
        f.close
        FileUtils::rm(outfn1)
      end
      # ---- Compare the two files
      compare_files(outfn,reffn,options[:ignore])
    end

    def CliExec::compare_files fn1, fn2, ignore = nil
      if not File.exist?(fn2)
        FileUtils::cp(fn1,fn2)
        true
      else
        cmd = "diff #{fn2} #{fn1}"
        $stderr.print cmd+"\n"
        return true if Kernel.system(cmd) == true
        $stderr.print "If it is correct, execute \"cp #{fn1} #{fn2}\", and run again"
        false
      end
    end
  end

end
