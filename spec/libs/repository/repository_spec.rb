require File.dirname(__FILE__) + "/../../../libs/repository/repository"

describe Repository do
  before(:each) do
    @repository = Repository.new (File.dirname(__FILE__) + "/../../changeLogConfigTest.yml")
  end

  it "checks if the path to the directory of change log is correct" do
    expect("/home/marco/ruby_changeLogDeploy/spec/changeLogDeploy").to eq(@repository.get_path_change_log_deploy)
  end
  
  it "confirms that the last file read is empty" do
    expect(nil).to eq(@repository.get_last_reader_file)
  end
  
  it "get the list of emails separated by commas" do
    expect("sugamele.marco@gmail.com, hlegius@gmail.com").to eq(@repository.get_notification_emails)
  end
  
  it "Get the files that will be read to generate the changelog" do
    expect(2).to eq(@repository.get_files_change_log.size)
  end
  
end  
  
