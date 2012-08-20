module RegressionTest

  DEFAULT_TESTDIR = "test/data/regression"

  # Regression test runner compares output in ./test/data/regression (by default).
  # The convention is to have a file with names .ref (reference) and create .new
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
      # ---- Compare the two files
      compare_files(outfn,reffn)
    end

    def CliExec::compare_files fn1, fn2
      if not File.exist?(fn2)
        Kernel.system("cp -v #{fn1} #{fn2}")
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
