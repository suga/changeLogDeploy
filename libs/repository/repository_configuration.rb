require File.dirname(__FILE__) + "/../fileManager/fileReader/yaml_reader"

module RepositoryConfiguration
  attr_reader :path_file_yaml, :config_yml
  
  def configuration_repository(path_change_log_configuration) 
    @config_yml = YamlReader.new(path_change_log_configuration)
    @config_yml.configurations
    self
  end
  
  def get_path_change_log_deploy
    @config_yml.configurations['changeLogPath']
  end  
  
  def get_last_reader_file
    @config_yml.configurations['lastReaderFile']
  end
  
  def get_notification_emails
    @config_yml.configurations['notificationEmails']
  end
  
  def get_file_extension
    @config_yml.configurations['extensionFiles']
  end
  
  def get_limit_threads
    @config_yml.configurations['limitThreads']
  end
  
end