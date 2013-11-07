ChangeLogDeploy
==========

Gem ruby(1.9.3) that automates the comunication of changes in the source code. 
Sends email notifying developers and managers who are working in the project about the change.

	Example to install:

	- bundle install

    Example to run:	

    - ruby change_log_deploy.rb -p spec/changeLogConfigTest.yml

    Example to run all tests:
    	
    - rspec -I spec spec/