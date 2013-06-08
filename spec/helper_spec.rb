#COVERAGE=true rspec -I spec/
if ENV['COVERAGE']
    require 'simplecov'
    SimpleCov.start do
      add_filter 'spec/'
      add_group 'FileManager', "libs/fileManager"
      add_group 'Threads', "libs/threads"
      add_group 'Validators', "libs/validators"
      add_group 'Exceptions', "libs/exceptions"
     end
end