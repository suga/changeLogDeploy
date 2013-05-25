# encoding: utf-8
require File.dirname(__FILE__) + "/../../../libs/repository/repository"

describe Repository do
  before(:each) do
    @repository = Repository.new (File.dirname(__FILE__) + "/../../changeLogConfigTest.yml")
  end

  it "checks if the path to the directory of change log is correct" do
    expect("spec/changeLogDeploy").to eq(@repository.get_path_change_log_deploy)
  end
  
  it "confirms that the last file read is empty" do
    expect(nil).to eq(@repository.get_last_read_file)
  end
  
  it "get the list of emails separated by commas" do
    expect(2).to eq(@repository.get_notification_emails.size)
    expect("sugamele.marco@gmail.com").to eq(@repository.get_notification_emails[0])
    expect("hlegius@gmail.com").to eq(@repository.get_notification_emails[1])
  end
  
  it "Get the files that will be read to generate the changelog" do
    expect(2).to eq(@repository.get_files_change_log.size)
  end
  
  it "Get limit threads to be executed in the system" do
    expect(4).to eq(@repository.get_limit_threads)
  end
  
  it "get the full change log" do
    @repository.get_change_log.should match(/test/)
    @repository.get_change_log.should match(/á test2/)
  end
  
end  
  
