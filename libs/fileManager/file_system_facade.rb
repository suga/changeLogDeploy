require File.dirname(__FILE__) + "/configuration_file"
require File.dirname(__FILE__) + "/../threads/pool_threads"
class FileSystemFacade

  attr_reader :configuration_file, :files_change_log

  def initialize(path_change_log_configuration)
    @files_change_log = Array.new
    @configuration_file = ConfigurationFile.new path_change_log_configuration
  end

  def to_email
    to_email = Array.new
    to_email.push(@configuration_file.notification_emails)
    to_email.push(merge_content_files)
  end

  def save_last_read_file
    @configuration_file.set_last_read_file(last_file_reader)
    @configuration_file.save_configuration
  end

  def merge_content_files
    content = PoolThreads.new files_new
    content.run_limit_threads @configuration_file.limit_threads
    content.get_merge_content_files
  end

  def last_file_reader
      last_file = files_new
      last_file[0].mtime
  end  

  def files_new
    if (@files_change_log.empty?)
      @files_change_log = FileSystemReader.get_files_change_log(@configuration_file.change_log_path, @configuration_file.extension_files, @configuration_file.last_read_file)
    end
    @files_change_log
  end

end