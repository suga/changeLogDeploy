require File.dirname(__FILE__) + "/../exceptions/configuration_exception"
require 'yaml'
require 'ostruct'

class ConfigurationFile
  
  attr_reader :yaml_configuration, :path_change_log_configuration
  
  def initialize(path_change_log_configuration)
    @path_change_log_configuration = path_change_log_configuration
    begin
      @yaml_configuration = YAML.load_file(path_change_log_configuration)            
    rescue Exception => e
      raise ConfigurationException.new 'Error reading the configuration file' + e.message
    end  
  end
  
  def configurations
    emails_to_array
    OpenStruct.new @yaml_configuration
  end  

  def set_last_read_file(last_read_file)
    @yaml_configuration['last_read_file'] = last_read_file
  end

  def save_configuration
    emails_to_string
    begin
      File.open(@path_change_log_configuration, 'w+') {|f| f.write(@yaml_configuration.to_yaml) }
    rescue Exception => e
      raise ConfigurationException.new 'Could not save your changes to the configuration file - ' + e.message
    end  
  end  
  
  private 
  def emails_to_array
    unless (@yaml_configuration['notification_emails'].kind_of?(Array))  
      @yaml_configuration['notification_emails'] = @yaml_configuration['notification_emails'].split(',').collect{|x| x.strip}
    end
  end

  def emails_to_string
    if (@yaml_configuration['notification_emails'].kind_of?(Array))  
      @yaml_configuration['notification_emails'] = @yaml_configuration['notification_emails'].join(',')
    end
  end  

end
