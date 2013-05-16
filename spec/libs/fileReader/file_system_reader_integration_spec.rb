require File.dirname(__FILE__) + "/../../../libs/fileReader/file_system_reader"
require 'tempfile'

describe FileSystemReader do
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
  
  it "Temos um arquivo novo, retornamos 1" do
    yml = YAML.load_file("spec/changeLogConfigTest.yml")
    yml["lastReaderFile"] = @file.mtime
    File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yml.to_yaml) }
    sleep 2

    @file4 = Tempfile.new(['20130516','.txt'])

    expect(FileSystemReader.get_files_change_log("/tmp", "txt", yml["lastReaderFile"]).size).to eq(1)

    @file4.close
    @file4.unlink

  end


end