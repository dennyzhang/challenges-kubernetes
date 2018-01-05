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
## Created : <2018-01-05>
## Updated: Time-stamp: <2018-01-05 17:33:46>
##-------------------------------------------------------------------
set -ex

echo "run mysqldump for mariadb DB"

# TODO
MARIADB_USERNAME=admin
MARIADB_PASSWORD=password
# https://github.com/kubernetes/charts/tree/master/stable/wordpress
/usr/bin/mysqldump -u ${MARIADB_USERNAME} --password=${MARIADB_PASSWORD} bitnami_wordpress > /tmp/backup.sql

# TODO: change this
sleep 10000
