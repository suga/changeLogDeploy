#!/usr/bin/ruby
require 'ostruct'
require 'optparse'
require File.dirname(__FILE__) + "/libs/validators/validator_path"
require File.dirname(__FILE__) + "/libs/fileManager/file_system_facade"

class ChangeLogDeploy
  attr_reader :options, :arguments, :configuration
  attr_accessor :path_resource_change_log
  
  def initialize(arguments)
    @arguments = arguments
  end
  
  def get_options
    @options = OpenStruct.new
    opts = OptionParser.new
    opts.on('-p','--path [FILE]', 'Path to resource file configuration') { |p| 
      validate_args = ValidatorPath.new p
      validate_args.is_valid?
      @options.path_change_log_configuration = p
    }
    opts.on("-h", "--help", "Show this message") { puts opts; exit }
    opts.parse!(@arguments) rescue abort 'Invalid options.'
  end
  
  def run
    get_options
    facade = FileSystemFacade.new @options.path_change_log_configuration
    puts facade.to_email.inspect
    #SendEmail(facade.to_email).send
    #facade.save_last_read_file
  end
  
  
end

changeLog = ChangeLogDeploy.new(ARGV)
changeLog.run


