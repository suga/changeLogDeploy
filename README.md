![alt text](https://travis-ci.org/suga/changeLogDeploy.svg?branch=master "Build by Travis") <br>
 [![Coverage Status](https://coveralls.io/repos/suga/changeLogDeploy/badge.png)](https://coveralls.io/r/suga/changeLogDeploy) <br>
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
