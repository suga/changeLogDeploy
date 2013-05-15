require File.dirname(__FILE__) + "/../../../libs/validators/validator_path"

describe ValidatorPathTest do
  before(:all) do
    @path_not_existis = '/tmp/not_exists.yml'    
    @path_exists = '/tmp/test_config.yml'
    File.new('/tmp/test_config.yml', 'w')    
  end

  after(:all) do
   File.delete("/tmp/test_config.yml")
  end
  
  it "The file exists, may not throw exception" do    
    validator = ValidatorPath.new(@path_exists)
    expect { validator.config_exists_in_file_system? }.to_not raise_error
  end
  
  it "The file does not exist, then we have an exception" do
    validator = ValidatorPath.new(@path_not_existis)
    expect { validator.config_exists_in_file_system? }.to raise_error(FileException)
    expect { validator.config_exists_in_file_system? }.to raise_error(/File not found. The specified file was/)
  end
  
  it "The file has read permission, we have no exception" do
    validator = ValidatorPath.new(@path_exists)
    expect { validator.the_file_has_permission_read? }.to_not raise_error
  end
  
  it "The file is writable for this, we have no exception" do
    validator = ValidatorPath.new(@path_exists)
    expect { validator.the_file_has_permission_write? }.to_not raise_error
  end
  
  it "The file is valid, we have no exception" do
    validator = ValidatorPath.new(@path_exists)
    expect { validator.is_valid? }.to_not raise_error
  end  
  
end
