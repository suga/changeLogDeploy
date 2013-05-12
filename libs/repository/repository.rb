require File.dirname(__FILE__) + "/../fileReader/yaml_reader"

class Repository
  attr_reader :path_file_yaml, :config_yml
  
  def initialize(path_change_log_configuration)
    @config_yml = YamlReader.new(path_change_log_configuration)
  end
  
  def config_yml_reader
    @config_yml.configurations
  end
  
  def get_path_change_log_deploy
    config_yml_reader['changeLogPath']
  end  
  
  def get_last_reader_file
    config_yml_reader['lastReaderFile']
  end
  
  def get_notification_emails
    config_yml_reader['notificationEmails']
  end
  
end
