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
  end
  
  it "Search for files of type txt" do    
    expect(FileSystemReader.get_files_change_log("/tmp", "txt").size).to eq(3)
  end
  
end