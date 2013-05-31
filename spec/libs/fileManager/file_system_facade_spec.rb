require File.dirname(__FILE__) + "/../../../libs/fileManager/configuration_file"
require File.dirname(__FILE__) + "/../../../libs/fileManager/file_system_facade"
require 'tempfile'
require 'yaml'

describe FileSystemFacade do
  WITH_TO_EMAIL = true

  context "Catch information to email" do
    before(:all) do
      send_email_to      
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
  
    it "checks information (from) to send email" do
       expect('noreply@someCompany.com').to eq(@to_email.from)
    end

    it "checks information (subject) to send email" do
       expect('to test').to eq(@to_email.subject)
    end

    it "checks information (to) to send email" do
       expect('sugamele.marco@gmail.com').to eq(@to_email.to)
    end

    it "checks information (cc) to send email" do
       expect('hlegius@gmail.com').to eq(@to_email.cc)
    end

    it "checks information (content) to send email" do
       @to_email.content.should match(/file1/)
       @to_email.content.should match(/file2/)
       @to_email.content.should match(/file3/)
    end
  end


  context "Many emails in copy" do
    before(:all) do
      send_email_to("sugamele.marco@gmail.com, hlegius@gmail.com, email1@gmail.com, email2@gmail.com")      
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
  
    it "checks information (to) to send email" do
       expect('sugamele.marco@gmail.com').to eq(@to_email.to)
    end

    it "checks emails in copy" do
       expect('hlegius@gmail.com,email1@gmail.com,email2@gmail.com').to eq(@to_email.cc)
    end

  end


  context "No mail in copy" do
    before(:all) do
      send_email_to("sugamele.marco@gmail.com")      
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
  
    it "checks information (to) to send email" do
       expect('sugamele.marco@gmail.com').to eq(@to_email.to)
    end

    it "checks emails in copy" do
       expect(true).to eq(@to_email.cc.empty?)
    end

  end


  context "Save last file read" do
    before(:all) do
      send_email_to("sugamele.marco@gmail.com")      
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
  
    it "before some action" do
      yaml = YAML.load_file(@array_files[-1].path)
      expect(true).to eq(yaml['last_read_file'].nil?)
    end

    it "checks information after save" do
      yaml = config_after_save_last_file    
      expect(false).to eq(yaml['last_read_file'].nil?)      
    end

  end


  context "Save last file read after call to_email" do
    before(:all) do
      send_email_to("sugamele.marco@gmail.com")      
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end

    it "checks information after save" do
      yaml = config_after_save_last_file(WITH_TO_EMAIL)
    
      expect(false).to eq(yaml['last_read_file'].nil?)
      expect("/tmp").to eq(yaml['change_log_path'])
      expect("sugamele.marco@gmail.com").to eq(yaml['notification_emails'])
      expect("noreply@someCompany.com").to eq(yaml['from'])
      expect("to test").to eq(yaml['subject'])
    end

  end


  def send_email_to (text_to_change_log_config_yml = "")
    
    emails = text_to_change_log_config_yml.empty? ? "\r\nnotification_emails: sugamele.marco@gmail.com, hlegius@gmail.com" : "\r\nnotification_emails: #{text_to_change_log_config_yml}"
    txt_yml = "---\r\nchange_log_path: /tmp\r\nlast_read_file: \r\nextension_files: txt\r\nlimit_threads: 4\r\nfrom: noreply@someCompany.com\r\nsubject: to test#{emails}"
    
    file = lambda do  |text_config_yml|
        array_files = Array.new
        (1..3).each do |n| 
          temp_file = Tempfile.new(["#{n}",'.txt'])
          temp_file.write("- Description fixeds and bugfix\r\nfile#{n}")
          temp_file.rewind
          array_files.push(temp_file) 
        end
        temp_file = Tempfile.new(['ChangeLogConfig','.yml'])
        temp_file.write("#{text_config_yml}")
        temp_file.rewind
        array_files.push(temp_file)
        array_files
      end
    
    @array_files = file.call (txt_yml)
    facade = FileSystemFacade.new @array_files[-1].path
    @to_email = facade.to_email  
  end

  def config_after_save_last_file(with_to_email = nil)
    facade = FileSystemFacade.new @array_files[-1].path
    facade.to_email if with_to_email == true
    facade.save_last_read_file
    YAML.load_file(@array_files[-1].path)
  end

end

