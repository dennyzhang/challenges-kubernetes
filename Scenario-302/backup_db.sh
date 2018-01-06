#!/usr/bin/env bash
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://www.dennyzhang.com/wp-content/mit_license.txt
##
## File: hello
## Author : Denny <https://www.dennyzhang.com/contact>
## Description :
## --
## Created : <2018-01-06>
## Updated: Time-stamp: <2018-01-06 09:52:19>
##-------------------------------------------------------------------
set -ex

/usr/bin/mysqldump -ubn_wordpress -p8fwWcgBn5V \
                   -P3306 -hmy-wordpress-mariadb \
                   bitnami_wordpress --result-file=/backup/db_backup.sql
## File: hello ends
