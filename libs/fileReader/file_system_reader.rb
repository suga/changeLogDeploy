class FileSystemReader
  
  def self.get_files_change_log (path_to_reader, extension_file)
    files_change_logs = Array.new
    Dir.glob(path_to_reader+'/*.'+extension_file).each do  |full_path_file|    
      files_change_logs.push(File.new(full_path_file))
    end      
    files_change_logs
  end
  
end