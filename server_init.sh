﻿#!/bin/sh

#-------------------------------------------------------------------------------------------------------------
# parameters
export OPE_USER_NAME='opeuser'
export OPE_USER_PASS='WudlyB3lh6'
export PWD_MYSQL='xy7VngsiZ4'


#-------------------------------------------------------------------------------------------------------------
# security_setup & useradd
security_setup.sh

#-------------------------------------------------------------------------------------------------------------
# apache,mysql,php setup
middle_setup.sh