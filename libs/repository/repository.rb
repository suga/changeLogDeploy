require File.dirname(__FILE__) + "/repository_configuration"
require File.dirname(__FILE__) + "/repository_file_system"

class Repository
  attr_reader :repository_configuration
  
  def initialize(path_change_log_configuration)
    @path_change_log_configuration = path_change_log_configuration
    @repository_configuration = self.extend(RepositoryConfiguration).configuration_repository(@path_change_log_configuration)
  end
  
  def repository_file_system
    self.extend(RepositoryFileSystem).configuration_repository(get_path_change_log_deploy, get_file_extension)
  end
  
  def get_path_change_log_deploy
    @repository_configuration.get_path_change_log_deploy
  end  
  
  def get_last_reader_file
    @repository_configuration.get_last_reader_file
  end
  
  def get_notification_emails
    @repository_configuration.get_notification_emails
  end
  
  def get_file_extension
    @repository_configuration.get_file_extension
  end
  
  def get_files_change_log
    repository_file_system.get_files
  end
  
end
