#!/usr/bin/ruby
require 'ostruct'
require 'optparse'
require File.dirname(__FILE__) + "/libs/validators/validator_path"
require File.dirname(__FILE__) + "/libs/repository/repository"

class ChangeLogDeploy
  attr_reader :options, :arguments, :configuration
  attr_accessor :path_resource_change_log
  
  def initialize(arguments)
    @arguments = arguments
    @options = OpenStruct.new
    parse_options
    validate_args = ValidatorPath.new @options.path_change_log_configuration
    validate_args.is_valid?
    repository = Repository.new @options.path_change_log_configuration
    puts repository.get_change_log
    
  end
  
  def parse_options
    opts = OptionParser.new
    opts.on('-p','--path [FILE]', 'Path to resource file configuration') { |p| @options.path_change_log_configuration = p}
    opts.on("-h", "--help", "Show this message") { puts opts; exit }
    opts.parse!(@arguments) rescue abort 'Invalid options.'
  end
  
  
  
end

ChangeLogDeploy.new(ARGV)


