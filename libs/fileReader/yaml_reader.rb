require 'yaml'

class YamlReader
  
  attr_reader :yaml_configuration
  
  def initialize(path_change_log_configuration)
    @yaml_configuration = YAML.load_file(path_change_log_configuration)
    emails_to_array    
  end
  
  def configurations
    @yaml_configuration
  end
  
  private
  def emails_to_array 
    @yaml_configuration['notificationEmails'] = @yaml_configuration['notificationEmails'].split(',').collect{|x| x.strip}
  end
    
end
