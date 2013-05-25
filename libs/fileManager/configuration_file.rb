require File.dirname(__FILE__) + "/../exceptions/configuration_exception"
require 'yaml'

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
  
  def change_log_path
    @yaml_configuration['changeLogPath']
  end

  def last_reader_file
    @yaml_configuration['lastReaderFile']
  end  

  def notification_emails
    emails_to_array
    @yaml_configuration['notificationEmails']
  end

  def extension_files
    @yaml_configuration['extensionFiles']
  end

  def limit_threads
    @yaml_configuration['limitThreads']
  end

  def set_last_reader_file(last_reader_file)
    @yaml_configuration['lastReaderFile'] = last_reader_file
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
    unless (@yaml_configuration['notificationEmails'].kind_of?(Array))  
      @yaml_configuration['notificationEmails'] = @yaml_configuration['notificationEmails'].split(',').collect{|x| x.strip}
    end
  end

  def emails_to_string
    if (@yaml_configuration['notificationEmails'].kind_of?(Array))  
      @yaml_configuration['notificationEmails'] = @yaml_configuration['notificationEmails'].join(',')
    end
  end  

end
