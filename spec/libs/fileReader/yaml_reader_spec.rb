require File.dirname(__FILE__) + "/../../../libs/fileReader/yaml_reader"

describe YamlReader, '.configurations' do
  before(:each) do
    @yaml = double("yaml_reader")
    @yaml.stub('configurations').and_return({"changeLogPath"=>"/home/marco/ruby_changeLogDeploy/changeLogs", "lastReaderFile"=>nil, "notificationEmails"=>"sugamele.marco@gmail.com, hlegius@gmail.com"})
  end

  it "checks if the path to the directory of change log is correct" do
    expect("/home/marco/ruby_changeLogDeploy/changeLogs").to eq(@yaml.configurations['changeLogPath'])
  end
  
  it "confirms that the last file read is empty" do
    expect(nil).to eq(@yaml.configurations['lastReaderFile'])
  end
  
  it "get the list of emails separated by commas" do
    expect("sugamele.marco@gmail.com, hlegius@gmail.com").to eq(@yaml.configurations['notificationEmails'])
  end
  
end

