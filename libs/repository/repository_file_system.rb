require File.dirname(__FILE__) + "/../fileManager/fileReader/file_system_reader"
require File.dirname(__FILE__) + "/../threads/pool_threads"

module RepositoryFileSystem
  attr_accessor :repository_configuration, :files_change_log
  
  def configuration_repository(repository_configuration)
    @files_change_log = Array.new    
    @repository_configuration = repository_configuration
    self
  end
  
  def get_files
    if (@files_change_log.empty?)
      @files_change_log = FileSystemReader.get_files_change_log(@repository_configuration.get_path_change_log_deploy, @repository_configuration.get_file_extension, @repository_configuration.get_last_reader_file)
    end
    @files_change_log
  end
  
  def get_content_files
    content = PoolThreads.new get_files
    content.run_limit_threads @repository_configuration.get_limit_threads
    content.get_merge_content_files
  end

  def last_file_reader
      last_file = get_files
      last_file[0].mtime
  end  
  
end
