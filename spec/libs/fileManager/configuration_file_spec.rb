require File.dirname(__FILE__) + "/../../../libs/fileManager/configuration_file"
require 'tempfile'

describe ConfigurationFile do
  before(:each) do
    configuration_file = ConfigurationFile.new(File.dirname(__FILE__) + "/../../changeLogConfigTest.yml")
    @configurations = configuration_file.configurations
  end
  
  context "Reading configuration information" do
  
    it "checks if the path to the directory of change log is correct" do
       expect("spec/changeLogDeploy").to eq(@configurations.change_log_path)
    end

    it "checks if the last file read is correct" do
      expect(nil).to eq(@configurations.last_read_file)
    end

    it "get the list of emails" do
      expect(2).to eq(@configurations.notification_emails.size)
      ["sugamele.marco@gmail.com","hlegius@gmail.com"].each_with_index do |email, index|
        expect(email).to eq(@configurations.notification_emails[index])
      end
    end

    it "check if extesion file is correct" do
       expect("txt").to eq(@configurations.extension_files)
    end

    it "check if limit threads is correct" do
       expect(4).to eq(@configurations.limit_threads)
    end

  end

  context "Saving configuration information" do

    before(:all) do
      @yaml_file  = Tempfile.new(['ChangeLogConfig','.yml'])
      @yaml_file.write("---\r\nchange_log_path: /home/marco/ruby_changeLogDeploy/changeLogs\r\nlast_read_file: \r\nnotification_emails: sugamele.marco@gmail.com, hlegius@gmail.com")
      @yaml_file.rewind
    end

    after(:all) do
      @yaml_file.close
      @yaml_file.unlink
    end

    it "Saving information from the last file read" do

      configuration_file = ConfigurationFile.new(@yaml_file.path)
      configurations = configuration_file.configurations
      expect(nil).to eq(configurations.last_read_file)

      configuration_file.set_last_read_file('2013-05-25 01:17:38 -0300')
      configuration_file.save_configuration

      new_configuration = ConfigurationFile.new(@yaml_file.path)
      new_configurations = new_configuration.configurations
      expect('2013-05-25 01:17:38 -0300').to eq(new_configurations.last_read_file)  

    end  

  end

  context "Forcing an error" do

    it "Forcing an error in reading the file" do
      expect { ConfigurationFile.new('/tmp/file_not_exists.yml') }.to raise_error(ConfigurationException)
    end  

  end
  
end

