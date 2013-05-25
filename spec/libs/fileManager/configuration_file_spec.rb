require File.dirname(__FILE__) + "/../../../libs/fileManager/configuration_file"
require 'tempfile'

describe ConfigurationFile do
  before(:each) do
    @configuration = ConfigurationFile.new(File.dirname(__FILE__) + "/../../changeLogConfigTest.yml")
  end
  
  context "Reading configuration information" do
  
    it "checks if the path to the directory of change log is correct" do
       expect("spec/changeLogDeploy").to eq(@configuration.change_log_path)
    end

    it "checks if the last file read is correct" do
      expect(nil).to eq(@configuration.last_reader_file)
    end

    it "get the list of emails" do
      expect(2).to eq(@configuration.notification_emails.size)
      ["sugamele.marco@gmail.com","hlegius@gmail.com"].each_with_index do |email, index|
        expect(email).to eq(@configuration.notification_emails[index])
      end
    end

    it "check if extesion file is correct" do
       expect("txt").to eq(@configuration.extension_files)
    end

    it "check if limit threads is correct" do
       expect(4).to eq(@configuration.limit_threads)
    end

  end

  context "Saving configuration information" do

    before(:all) do
      @yaml_file  = Tempfile.new(['ChangeLogConfig','.yml'])
      @yaml_file.write("---\r\nchangeLogPath: /home/marco/ruby_changeLogDeploy/changeLogs\r\nlastReaderFile: \r\nnotificationEmails: sugamele.marco@gmail.com, hlegius@gmail.com")
      @yaml_file.rewind
    end

    after(:all) do
      @yaml_file.close
      @yaml_file.unlink
    end

    it "Saving information from the last file read" do

      configuration = ConfigurationFile.new(@yaml_file.path)
      expect(nil).to eq(configuration.last_reader_file)

      configuration.set_last_reader_file('2013-05-25 01:17:38 -0300')
      configuration.save_configuration

      new_configuration = ConfigurationFile.new(@yaml_file.path)
      expect('2013-05-25 01:17:38 -0300').to eq(configuration.last_reader_file)  

    end  

  end

  context "Forcing an error" do

    it "Forcing an error in reading the file" do
      expect { ConfigurationFile.new('/tmp/file_not_exists.yml') }.to raise_error(ConfigurationException)
    end  

  end
  
end

