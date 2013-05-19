# encoding: utf-8
require File.dirname(__FILE__) + "/../../../libs/threads/pool_threads"
require 'tempfile'

describe PoolThreads do
  
  context "Do merge the contents of the files using threads" do
    
    before(:all) do
      @file  = Tempfile.new(['201305131','.txt'])
      @file.write("- Description fixeds and bugfix\r\nfile1")
      @file.rewind
      
      @file1 = Tempfile.new(['201305142','.txt'])
      @file1.write("- Description fixeds and bugfix\r\nfile2")
      @file1.rewind
      
      @file2 = Tempfile.new(['201305153','.txt'])
      @file2.write("- Description fixeds and bugfix\r\nfile3")
      @file2.rewind
      
      @file3 = Tempfile.new(['201305144','.txt'])
      @file3.write("- Description fixeds and bugfix\r\nfile4")
      @file3.rewind
      
      @file4 = Tempfile.new(['201305155','.txt'])
      @file4.write("- Description fixeds and bugfix\r\nfile5")
      @file4.rewind
      
      @file5 = Tempfile.new(['201305146','.txt'])
      @file5.write("- Description fixeds and bugfix\r\nfile6")
      @file5.rewind
      
      @file6 = Tempfile.new(['201305157','.txt'])
      @file6.write("- Description fixeds and bugfix\r\nfile7")
      @file6.rewind
      
      @file7 = Tempfile.new(['201305148','.txt'])
      @file7.write("- Description fixeds and bugfix\r\nfile8")
      @file7.rewind
      
      @file8 = Tempfile.new(['201305159','.txt'])
      @file8.write("- Description fixeds and bugfix\r\nfile9")
      @file8.rewind
      
      @file9 = Tempfile.new(['2013051411','.txt'])
      @file9.write("- á é à ç ü \r\nfile10")
      @file9.rewind
    end

    after(:all) do
      @file.close
      @file1.close
      @file2.close
      @file3.close
      @file4.close
      @file5.close
      @file6.close
      @file7.close
      @file8.close
      @file9.close
      
      @file.unlink
      @file1.unlink
      @file2.unlink
      @file3.unlink
      @file4.unlink
      @file5.unlink
      @file6.unlink
      @file7.unlink
      @file8.unlink
      @file9.unlink
      
    end
   
   it "The merge should contain the contents of all files" do
      files = Array.new
      files.push(@file)
      files.push(@file1)
      files.push(@file2)
      files.push(@file3)
      files.push(@file4)
      files.push(@file5)
      files.push(@file6)
      files.push(@file7)
      files.push(@file8)
      files.push(@file9)
      
      contents = PoolThreads.new files
      contents.run_limit_threads 4
      merge_contents = contents.get_merge_content_files

      merge_contents.should match(/Description fixeds and bugfix\r\nfile1/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile2/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile3/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile4/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile5/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile6/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile7/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile8/)
      merge_contents.should match(/Description fixeds and bugfix\r\nfile9/)
      merge_contents.should match(/- á é à ç ü \r\nfile10/)
      merge_contents.should match(/---------------/)
    end    
  end


end