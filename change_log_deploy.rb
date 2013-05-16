#!/usr/bin/ruby
require 'ostruct'
require 'optparse'
require File.dirname(__FILE__) + "/libs/repository/repository"
require File.dirname(__FILE__) + "/libs/fileReader/file_system_reader"

class ChangeLogDeploy
  attr_reader :options, :arguments, :configuration
  attr_accessor :path_resource_change_log
  
  def initialize(arguments)
    @arguments = arguments
    @options = OpenStruct.new
    parse_options
    repository = Repository.new @options.path_change_log_configuration
#    puts @options.path_change_log_configuration
#    puts File.mtime(@options.path_change_log_configuration)
#    if(File.mtime(@options.path_change_log_configuration) < File.mtime('change_log_deploy.rb'))
#      puts 'opa'
#    end
#    
#    file_system = FileSystemReader.new
#    file_system.get_files_change_log("/home/marco/ruby_changeLogDeploy/tests/libs/fileReader/changeLogDeploy", "txt").reverse_each { |file|
#      puts file.path, file.mtime
#    }
    
    puts repository.get_path_change_log_deploy
    repository.get_files_change_log.each { |file|
      puts file.path, file.mtime
    }
    
  end
  
  def parse_options
    opts = OptionParser.new
    opts.on('-p','--path [FILE]', 'Path to resource file configuration') { |p| @options.path_change_log_configuration = p}
    opts.on("-h", "--help", "Show this message") { puts opts; exit }
    opts.parse!(@arguments) rescue abort 'Invalid options.'
  end
  
  
  
end

ChangeLogDeploy.new(ARGV)


