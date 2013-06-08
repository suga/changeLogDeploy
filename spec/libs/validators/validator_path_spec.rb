require File.dirname(__FILE__) + "/../../../libs/validators/validator_path"
require 'tempfile'

describe ValidatorPath do
  before(:each) do
    @path_not_existis = '/tmp/not_exists.yml'    
    @file = Tempfile.new(['20130516','.yml'])
    @path_exists = @file.path        
  end

  after(:each) do
   @file.close
   @file.unlink
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

  it "The file is not writable for this, we have exception" do
    FileUtils.chmod 0111, @path_exists
    validator = ValidatorPath.new(@path_exists)
    expect { validator.the_file_has_permission_write? }.to raise_error
  end

  it "The file has not read permission, we have exception" do
    FileUtils.chmod 0111, @path_exists
    validator = ValidatorPath.new(@path_exists)
    expect { validator.the_file_has_permission_read? }.to raise_error
  end
  
end
