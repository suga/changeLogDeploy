require File.dirname(__FILE__) + "/../fileManager/file_system_reader"
require 'thread'

class PoolThreads
  attr_reader :files
  attr_writer :content
  
  def initialize files_to_reader
    @files = files_to_reader
    @content = ''
  end
  
  def run_limit_threads amount_threads = 4
    queue = Queue.new
    @files.length.times do
      queue << 1
    end    
    
    @files.each do |file|
      while true do
        sleep 0.1 if active_threads >= amount_threads        
        Thread.new do
          @content << "#{FileSystemReader.get_content file}"            
          @content << "\r\n---------------\r\n" if queue.length > 1
          queue.pop            
        end
        break
      end
    end

    join_threads    
  end
  
  def get_merge_content_files
    @content
  end
  
  private
  def active_threads
    count = 0
    Thread.list.each do |t|
      if Thread.main != t and (t.status == "run" || t.status == "sleep")
        count = count + 1
      end
    end
    count
  end
  
  def join_threads
    Thread.list.each do |t|
      if Thread.main != t
        t.join
      end
    end
  end
  
end