require File.dirname(__FILE__) + "/../fileManager/configuration_file"
require File.dirname(__FILE__) + "/repository_file_system"

class Repository
  attr_reader :repository_file_system
  
  def initialize(path_change_log_configuration)
    @path_change_log_configuration = path_change_log_configuration
    @configuration_file =  ConfigurationFile.new(@path_change_log_configuration)
  end
  
  def repository_file_system
    unless(@repository_file_system.is_a? RepositoryFileSystem)
      @repository_file_system = self.extend(RepositoryFileSystem).configuration_repository(@configuration_file)
    end      
    @repository_file_system
  end
  
  def get_path_change_log_deploy
    @configuration_file.change_log_path
  end  
  
  def get_last_read_file
    @configuration_file.last_read_file
  end
  
  def get_notification_emails
    @configuration_file.notification_emails
  end
  
  def get_file_extension
    @configuration_file.extension_files
  end
  
  def get_limit_threads
    @configuration_file.limit_threads
  end
  
  def get_files_change_log
    repository_file_system.get_files
  end
  
  def get_change_log
    repository_file_system.get_content_files
  end
  
  def get_last_file_reader
    repository_file_system.last_file_reader
  end

end
