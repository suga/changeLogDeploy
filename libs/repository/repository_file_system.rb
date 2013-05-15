require File.dirname(__FILE__) + "/../fileReader/file_system_reader"

module RepositoryFileSystem
  attr_reader :path_to_reader, :extension_file
  
  def configuration_repository(path_to_reader, extension_file)    
    @path_to_reader = path_to_reader
    @extension_file = extension_file
    self
  end
  
  def get_files
    FileSystemReader.get_files_change_log(@path_to_reader, @extension_file)
  end
  
end
