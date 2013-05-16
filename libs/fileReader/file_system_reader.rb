class FileSystemReader
  
  def self.get_files_change_log (path_to_reader, extension_file, last_file_reader = nil)
    files_change_logs = Array.new
    Dir.glob(path_to_reader+'/*.'+extension_file).reverse.each do  |full_path_file|    
      file = File.new(full_path_file) 
      if (!last_file_reader.to_s.empty? && file.mtime > last_file_reader)
          files_change_logs.push(file)
      end      
      if (last_file_reader.to_s.empty?)
        files_change_logs.push(file)
      end
    end      
    files_change_logs
  end

end