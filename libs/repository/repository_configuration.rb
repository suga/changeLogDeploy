require File.dirname(__FILE__) + "/../fileManager/configuration_file"

module RepositoryConfiguration
  attr_reader :path_file_yaml, :config_yml
  
  def configuration_repository(path_change_log_configuration) 
    @config_yml = ConfigurationFile.new(path_change_log_configuration)
    self
  end
  
  def get_path_change_log_deploy
    @config_yml.change_log_path
  end  
  
  def get_last_reader_file
    @config_yml.last_reader_file
  end
  
  def get_notification_emails
    @config_yml.notification_emails
  end
  
  def get_file_extension
    @config_yml.extension_files
  end
  
  def get_limit_threads
    @config_yml.limit_threads
  end
  
end