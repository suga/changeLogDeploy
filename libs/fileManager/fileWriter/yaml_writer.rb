require File.dirname(__FILE__) + "/../../exceptions/file_exception"

class YamlWriter
  
  def self.write_in_file_system (path_to_file_yaml, yaml_file_content)
    begin
      File.open(path_to_file_yaml, 'w+') {|f| f.write(yaml_file_content.to_yaml) }
    rescue Exception => e
      raise FileException 'Could not save your changes to the configuration file - ' + e.message
    end  
  end
  
end
