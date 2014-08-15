![alt text](https://travis-ci.org/suga/changeLogDeploy.svg?branch=master "Build by Travis") <br>
 [![Test Coverage](https://codeclimate.com/github/suga/changeLogDeploy/badges/coverage.svg)](https://codeclimate.com/github/suga/changeLogDeploy) <br>
 [![Code Climate](https://codeclimate.com/github/suga/changeLogDeploy/badges/gpa.svg)](https://codeclimate.com/github/suga/changeLogDeploy)
<br>
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
