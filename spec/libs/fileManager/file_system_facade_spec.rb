require File.dirname(__FILE__) + "/../../../libs/fileManager/configuration_file"
require File.dirname(__FILE__) + "/../../../libs/fileManager/file_system_facade"
require 'tempfile'

describe FileSystemFacade do
  
  context "Catch information to email" do
    before(:all) do
      file = lambda do  
        array_files = Array.new
        (1..3).each do |n| 
          temp_file = Tempfile.new(["#{n}",'.txt'])
          temp_file.write("- Description fixeds and bugfix\r\nfile#{n}")
          temp_file.rewind
          array_files.push(temp_file) 
        end
        temp_file = Tempfile.new(['ChangeLogConfig','.yml'])
        temp_file.write("---\r\nchangeLogPath: /tmp\r\nlastReaderFile: \r\nnotificationEmails: sugamele.marco@gmail.com, hlegius@gmail.com\r\nextensionFiles: txt\r\nlimitThreads: 4")
        temp_file.rewind
        array_files.push(temp_file)
        array_files
      end
      @array_files = file.call
    end

    after(:all) do
      @array_files.each { |file| file.close file.unlink }
    end
  
    it "checks information to send email" do
       facade = FileSystemFacade.new @array_files[-1].path
       to_email = facade.to_email
       expect(2).to eq(to_email.size)
       expect(["sugamele.marco@gmail.com", "hlegius@gmail.com"]).to eq(to_email[0])
       to_email[1].should match(/file1/)
       to_email[1].should match(/file2/)
       to_email[1].should match(/file3/)
    end

  end
end

