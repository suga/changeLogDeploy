require 'yaml'

class YamlReader
  
  attr_reader :yaml_configuration
  
  def initialize(path_change_log_configuration)
    @yaml_configuration = YAML.load_file(path_change_log_configuration)
  end
  
  def configurations
    configure_emails_to_array
    @yaml_configuration
  end
  
  private
  def configure_emails_to_array
    if (!@yaml_configuration['notificationEmails'].kind_of?(Array))  
        @yaml_configuration['notificationEmails'] = @yaml_configuration['notificationEmails'].split(',').collect{|x| x.strip}
    end
  end
    
end
