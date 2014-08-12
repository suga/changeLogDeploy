#!/usr/bin/ruby
require 'ostruct'
require 'optparse'
require 'pony'
require File.dirname(__FILE__) + "/libs/validators/validator_path"
require File.dirname(__FILE__) + "/libs/fileManager/file_system_facade"

class ChangeLogDeploy
  attr_reader :options, :arguments
  
  def initialize(arguments)
    @arguments = arguments
  end
  
  def get_options
    @options = OpenStruct.new
    @options.view_email = false
    opts = OptionParser.new
    opts.on('-p','--path [FILE]', 'Path to resource file configuration') { |p| 
      validate_args = ValidatorPath.new p
      validate_args.is_valid?
      @options.path_change_log_configuration = p
    }
    opts.on("-v", "--view", "Show email") { 
      @options.view_email = true
    }
    opts.on("-h", "--help", "Show this message") { puts opts; exit }
    opts.parse!(@arguments) rescue abort 'Invalid options.'
  end
  
  def run
    get_options 
    return view if options.view_email
    send_mail and facade.save_last_read_file
  rescue Exception => e
    puts 'An error ocurred when sending the email'
    puts "Error: #{e.message}"
  end

  def view
    puts 'To: '      + facade.to_email.to
    puts 'Cc: '      + facade.to_email.cc
    puts 'From: '    + facade.to_email.from
    puts 'Subject: ' + facade.to_email.subject
    puts 'Content: ' + facade.to_email.content
  end  

  private 

  def send_mail
    Pony.mail(
      via:     :sendmail, 
      charset: 'utf-8', 
      to:      facade.to_email.to, 
      cc:      facade.to_email.cc, 
      from:    facade.to_email.from, 
      subject: facade.to_email.subject, 
      body:    facade.to_email.content
    )
  end

  def facade
    @facade ||= FileSystemFacade.new(options.path_change_log_configuration)
  end  
end

changeLog = ChangeLogDeploy.new(ARGV)
changeLog.run
