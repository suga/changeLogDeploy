require File.dirname(__FILE__) + "/../fileManager/fileReader/file_system_reader"
require File.dirname(__FILE__) + "/../threads/pool_threads"

module RepositoryFileSystem
  attr_accessor :configuration_file, :files_change_log
  
  def configuration_repository(configuration_file)
    @files_change_log = Array.new    
    @configuration_file = configuration_file
    self
  end
  
  def get_files
    if (@files_change_log.empty?)
      @files_change_log = FileSystemReader.get_files_change_log(@configuration_file.change_log_path, @configuration_file.extension_files, @configuration_file.last_read_file)
    end
    @files_change_log
  end
  
  def get_content_files
    content = PoolThreads.new get_files
    content.run_limit_threads @configuration_file.limit_threads
    content.get_merge_content_files
  end

  def last_file_reader
      last_file = get_files
      last_file[0].mtime
  end  
  
end
