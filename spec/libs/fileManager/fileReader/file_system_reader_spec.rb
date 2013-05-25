# encoding: utf-8
require File.dirname(__FILE__) + "/../../../../libs/fileManager/fileReader/file_system_reader"
require 'tempfile'
require 'date'
require 'yaml'

describe FileSystemReader do
  
  context "Reading files new change log", :reading_new_files => true do
    
    before(:all) do
      file = lambda do |amount_text, amount_yml| 
        array_files = Array.new
        (1..amount_text).each { |n| array_files.push(Tempfile.new(["#{n}",'.txt'])) }
        (1..amount_yml).each { |n| array_files.push(Tempfile.new(["#{n}",'.yml'])) }
        array_files
      end
      @array = file.call(3,1)
    end

    after(:all) do
      @array.each { |file| file.close file.unlink }
      yaml_fixed_last_read_file(nil)      
    end

    it "No file was read, we have to return all txt" do      
       expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)       
    end

    it "The last time the file is smaller than those created, return all" do
      date = DateTime.new
      yaml_fixed_last_read_file((date-10).to_time)
      expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)      
    end

    it "We have a new file, return one data" do
      
      FileUtils.touch @array[2].path, :mtime => Time.new + 60*60*12
      yml = yaml_fixed_last_read_file(@array[2].mtime)
      
      @file4 = Tempfile.new(['20130516','.txt'])
      FileUtils.touch @file4.path, :mtime => Time.new + 60*60*24
      expect(FileSystemReader.get_files_change_log("/tmp", "txt", yml["lastReaderFile"]).size).to eq(1)

      @file4.close
      @file4.unlink
      
    end

    private
    def yaml_fixed_last_read_file(value)
      yaml = YAML.load_file("spec/changeLogConfigTest.yml")
      yaml["lastReaderFile"] = value
      File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yaml.to_yaml) }
      yaml      
    end    
  end

  context "Get the contents of files", :contents => true do
    
    before(:all) do
      content_file = ["Hello Word", "BugFix: Fixed error in some class\r\nFeature: Some feature here\r\nTests: é assim ó"]
      files = lambda do |content_file|          
          array_files = Array.new          
          content_file.each do |content, index|
            file  = Tempfile.new(["#{index}",'.txt'])
            file.write(content)
            file.rewind
            array_files.push(file)
          end
          array_files
      end
      @files = files.call(content_file)
    end

    after(:all) do
     @files.each { |file| file.close file.unlink}
    end
    
    it "Get the contents of files" do
      expect(FileSystemReader.get_content @files[0]).to eq("Hello Word")
      expect((FileSystemReader.get_content @files[1])).to eq("BugFix: Fixed error in some class\r\nFeature: Some feature here\r\nTests: é assim ó")
    end
    
  end
end