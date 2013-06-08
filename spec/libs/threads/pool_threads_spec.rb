# encoding: utf-8
require File.dirname(__FILE__) + "/../../../libs/threads/pool_threads"
require 'tempfile'

describe PoolThreads do
  
  context "Do merge the contents of the files using threads" do
    
    before(:all) do
      file = lambda do  
        array_files = Array.new
        (1..9).each do |n| 
          temp_file = Tempfile.new(["#{n}",'.txt'])
          temp_file.write("- Description fixeds and bugfix\r\nfile#{n}")
          temp_file.rewind
          array_files.push(temp_file) 
        end
        temp_file = Tempfile.new(['2013051411','.txt'])
        temp_file.write("- á é à ç ü \r\nfile#{array_files.size+1}")
        temp_file.rewind
        array_files.push(temp_file)
        array_files
      end
      @array_files = file.call
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
   
   it "The merge should contain the contents of all files" do
      contents = PoolThreads.new @array_files
      contents.run_limit_threads 9
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