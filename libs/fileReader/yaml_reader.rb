require 'yaml'

class YamlReader
  
  attr_reader :yaml_path_configuration
  
  def initialize(path_change_log_configuration)
    @yaml_path_configuration = path_change_log_configuration
  end
  
  def configurations
    YAML.load_file(@yaml_path_configuration)
  end
  
end
