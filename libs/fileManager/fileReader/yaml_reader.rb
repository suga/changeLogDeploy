require 'yaml'
require 'ostruct'

class ConfigurationFile
  
  attr_reader :yaml_configuration
  attr_writer :yaml_attr
  
  def initialize(path_change_log_configuration)
    @yaml_configuration = YAML.load_file(path_change_log_configuration)
  end
  
  def change_log_path
    @yaml_configuration['changeLogPath']
  end

  def last_reader_file
    @yaml_configuration['lastReaderFile']
  end  

  def notification_emails
    unless (@yaml_configuration['notificationEmails'].kind_of?(Array))  
      @yaml_configuration['notificationEmails'] = @yaml_configuration['notificationEmails'].split(',').collect{|x| x.strip}
    end
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
    
end
