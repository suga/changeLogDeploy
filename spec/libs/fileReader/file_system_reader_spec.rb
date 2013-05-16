require File.dirname(__FILE__) + "/../../../libs/fileReader/file_system_reader"
require 'tempfile'
require 'date'

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
  
  it "Nenhum arquivo foi lido, temos que retornar todos os txt" do
     expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)
  end

  it "O tempo do ultimo arquivo e menor que os que foram criados, retornamos todos" do
    date = DateTime.new
    yml = YAML.load_file("spec/changeLogConfigTest.yml")
    yml["lastReaderFile"] = (date-10).to_time
    File.open("spec/changeLogConfigTest.yml", 'w+') {|f| f.write(yml.to_yaml) }
    expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)
  end
 
  it "Temos um arquivo novo, retornamos 1" do
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