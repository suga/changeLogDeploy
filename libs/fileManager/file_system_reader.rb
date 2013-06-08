class FileSystemReader
  
  def self.get_files_change_log (path_to_reader, extension_file, last_read_file = nil)
    files_change_logs = Array.new
    Dir.glob(path_to_reader+'/*.'+extension_file).reverse.each do  |full_path_file|    
      file = File.new(full_path_file)
      if (!last_read_file.to_s.empty? && file.mtime > last_read_file)
          files_change_logs.push(file)
      end      
      if (last_read_file.to_s.empty?)
        files_change_logs.push(file)
      end
    end      
    files_change_logs
  end

  def self.get_content file
    File.open(file.path, 'rb') { |f| f.read.to_s.force_encoding("UTF-8") }
  end
  
end