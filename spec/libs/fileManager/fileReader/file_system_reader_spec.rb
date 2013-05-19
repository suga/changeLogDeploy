# encoding: utf-8
require File.dirname(__FILE__) + "/../../../../libs/fileManager/fileReader/file_system_reader"
require 'tempfile'
require 'date'
require 'yaml'

describe FileSystemReader do
  
  context "Reading files new change log", :reading_new_files => true do
    
    before(:all) do
      @file  = Tempfile.new(['20130513','.txt'])    
      @file1 = Tempfile.new(['20130514','.txt'])
      @file2 = Tempfile.new(['20130515','.txt'])
      @file3 = Tempfile.new(['20130513','.yml'])
    end

    after(:all) do
      @file.close
      @file1.close
      @file2.close
      @file3.close    
      @file.unlink
      @file1.unlink
      @file2.unlink
      @file3.unlink

      yml = YAML.load_file("spec/changeLogConfigTest.yml")
      yml["lastReaderFile"] = nil
      File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yml.to_yaml) }
    end

    it "No file was read, we have to return all txt" do
      
       expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)
       
    end

    it "The last time the file is smaller than those created, return all" do
      
      date = DateTime.new
      yml = YAML.load_file("spec/changeLogConfigTest.yml")
      yml["lastReaderFile"] = (date-10).to_time
      File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yml.to_yaml) }
      expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)
      
    end

    it "We have a new file, return one data" do
      
      FileUtils.touch @file3.path, :mtime => Time.new + 60*60*12
      yml = YAML.load_file("spec/changeLogConfigTest.yml")
      yml["lastReaderFile"] = @file3.mtime
      File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yml.to_yaml) }

      @file4 = Tempfile.new(['20130516','.txt'])
      FileUtils.touch @file4.path, :mtime => Time.new + 60*60*24
      expect(FileSystemReader.get_files_change_log("/tmp", "txt", yml["lastReaderFile"]).size).to eq(1)

      @file4.close
      @file4.unlink
      
    end    
  end

  context "Get the contents of files", :contents => true do
    
    before(:all) do
      @file  = Tempfile.new(['20130513','.txt'])
      @file.write("Hello Word")
      @file.rewind
      
      @file1 = Tempfile.new(['20130514','.txt'])
      @file1.write("BugFix: Fixed error in some class\r\nFeature: Some feature here\r\nTests: é assim ó")
      @file1.rewind
    end

    after(:all) do
      @file.close
      @file1.close
      @file.unlink
      @file1.unlink
    end
    
    it "Get the contents of files" do
      expect(FileSystemReader.get_content @file).to eq("Hello Word")
      expect((FileSystemReader.get_content @file1)).to eq("BugFix: Fixed error in some class\r\nFeature: Some feature here\r\nTests: é assim ó")
    end
    
  end
end