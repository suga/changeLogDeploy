require File.dirname(__FILE__) + "/../exceptions/file_exception"
class ValidatorPath 
  attr_reader :path_to_validate
  
  def initialize (path_to_validate)
    @path_to_validate = path_to_validate
  end
  
  def config_exists_in_file_system?
    unless(File.exists?(@path_to_validate))
      raise FileException, "File not found. The specified file was #{@path_to_validate}"
    end
  end
  
  def the_file_has_permission_read? 
    unless(File.readable?(@path_to_validate))
      raise FileException, "The file has not  permission reader. The specified file was #{@path_to_validate}"
    end
  end
  
  def the_file_has_permission_write? 
    unless(File.writable?(@path_to_validate))
      raise FileException, "The file has not  permission write. The specified file was #{@path_to_validate}"
    end
  end
  
  def is_valid?
    config_exists_in_file_system?
    the_file_has_permission_read? 
    the_file_has_permission_write?
  end
  
end
