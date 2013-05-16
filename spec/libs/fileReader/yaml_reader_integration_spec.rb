require File.dirname(__FILE__) + "/../../../libs/fileReader/yaml_reader"

describe YamlReader, '.configurations' do
  before(:each) do
    @yaml = YamlReader.new(File.dirname(__FILE__) + "/../../changeLogConfigTest.yml")
  end

  it "checks if the path to the directory of change log is correct" do
    expect("spec/changeLogDeploy").to eq(@yaml.configurations['changeLogPath'])
  end
  
  it "confirms that the last file read is empty" do
    expect(nil).to eq(@yaml.configurations['lastReaderFile'])
  end
  
  it "get the list of emails separated by commas" do
    expect("sugamele.marco@gmail.com, hlegius@gmail.com").to eq(@yaml.configurations['notificationEmails'])
  end
  
end

