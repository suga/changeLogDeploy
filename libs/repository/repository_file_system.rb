require File.dirname(__FILE__) + "/../fileManager/fileReader/file_system_reader"
require File.dirname(__FILE__) + "/../threads/pool_threads"

module RepositoryFileSystem
  attr_reader :repository_configuration
  
  def configuration_repository(repository_configuration)    
    @repository_configuration = repository_configuration
    self
  end
  
  def get_files
    FileSystemReader.get_files_change_log(@repository_configuration.get_path_change_log_deploy, @repository_configuration.get_file_extension, @repository_configuration.get_last_reader_file)
  end
  
  def get_content_files
    content = PoolThreads.new get_files
    content.run_limit_threads @repository_configuration.get_limit_threads
    content.get_merge_content_files
  end
  
end
