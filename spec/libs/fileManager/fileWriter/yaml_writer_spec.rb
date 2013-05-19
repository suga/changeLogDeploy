require File.dirname(__FILE__) + "/../../../../libs/fileManager/fileReader/yaml_reader"
require File.dirname(__FILE__) + "/../../../../libs/fileManager/fileWriter/yaml_writer"
require 'tempfile'
require 'yaml'

describe YamlWriter do
  context "Save the information in a yaml file" do 
    before(:all) do
      @yaml_file  = Tempfile.new(['ChangeLogConfig','.yml'])
      @yaml_file.write("---\r\nchangeLogPath: /home/marco/ruby_changeLogDeploy/changeLogs\r\nlastReaderFile: \r\nnotificationEmails: sugamele.marco@gmail.com, hlegius@gmail.com")
      @yaml_file.rewind
    end

    after(:all) do
      @yaml_file.close
      @yaml_file.unlink
    end
    
    it "save in yml file correctly" do
      yaml = YamlReader.new @yaml_file.path
      expect(nil).to eq(yaml.configurations['lastReaderFile'])
      
      yaml.configurations['lastReaderFile'] = @yaml_file.mtime
      
      YamlWriter.write_in_file_system @yaml_file.path, yaml.configurations
      
      yaml = YamlReader.new @yaml_file.path
      yaml.configurations['lastReaderFile'].to_s.should == @yaml_file.mtime.to_s
    end
    
  end
end

