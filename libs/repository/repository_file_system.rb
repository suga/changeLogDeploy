require File.dirname(__FILE__) + "/../fileReader/file_system_reader"

module RepositoryFileSystem
  attr_reader :repository_configuration
  
  def configuration_repository(repository_configuration)    
    @repository_configuration = repository_configuration
    self
  end
  
  def get_files
    FileSystemReader.get_files_change_log(@repository_configuration.get_path_change_log_deploy, @repository_configuration.get_file_extension, @repository_configuration.get_last_reader_file)
  end
  
end
