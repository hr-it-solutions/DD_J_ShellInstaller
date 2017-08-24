#!/bin/bash

# @package    HR IT-Solutions - Deployment - DD_J_ShellInstaller
#
# @author     HR IT-Solutions Florian Häusler <info@hr-it-solutions.com>
# @copyright  Copyright (C) 2017 - 2017 Didldu e.K. | HR IT-Solutions
# @license    http://www.gnu.org/licenses/gpl-2.0.html GNU/GPLv2 only

# Load config library functions
source "$PWD"/config.shlib;

## Configuration

WEB_ROOT="$(config_get WEB_ROOT)"

############

## Script

# FOLDER_NAME="USER INPUT"
read -p "Enter foldername to create (e.g. 'mywebsite'): " FOLDER_NAME
# J_VERSION="USER INPUT"
read -p "Enter Joomla version to get (e.g. '3.7.5'): " J_VERSION

# JoomlaPackage
JOOMLA_PACKAGE=Joomla_$J_VERSION-Stable-Full_Package.zip

# Remove folder if exists
rm -rf ${HOME}/$WEB_ROOT$FOLDER_NAME

# Create folder
mkdir ${HOME}/$WEB_ROOT$FOLDER_NAME

# Change to webdir
cd ${HOME}/$WEB_ROOT$FOLDER_NAME

# Get Joomla Version
wget https://github.com/joomla/joomla-cms/releases/download/$J_VERSION/$JOOMLA_PACKAGE

# Unzip Jooomla Version
unzip $JOOMLA_PACKAGE

rm $JOOMLA_PACKAGE

printf "\mkdir Joomla successfull\n"

# Function jinstall
jinstall () {

	# Place jinstaller.sql to sql mysql installation folder
	cp "$PWD"/jinstaller.sql ${HOME}/$WEB_ROOT$FOLDER_NAME/installation/sql/mysql/

	# DB_HOST="USER INPUT"
	read -p "Enter database host (e.g. 'localohost'): " DB_HOST
	# DB_USER="USER INPUT"
	read -p "Enter database user: " DB_USER
	# DB_NAME="USER INPUT"
	read -p "Enter database name: " DB_NAME
	# DB_PASSWORD="USER INPUT"
	read -p "Enter database password: " DB_PASSWORD
	# DB_PREFIX="USER INPUT"
	read -p "Enter database prefix (e.g. 'jos_'): " DB_PREFIX

	# Go to installation mysql folder
	cd installation/sql/mysql/

	# Add jinstaller.sql to joomla.sql
	cat jinstaller.sql >> joomla.sql

	# Set Prefix
	sed -i -e "s/#__/$DB_PREFIX/g" joomla.sql

	# MySQL Import
	mysql -h$DB_HOST -u$DB_USER -p$DB_PASSWORD $DB_NAME < joomla.sql

	# Go to installation folder
	cd ${HOME}/$WEB_ROOT$FOLDER_NAME/installation/

	# Set Configuration.php
	sed -i -e "s/host = \x27localhost\x27/host = \x27$DB_HOST\x27/g" configuration.php-dist
	sed -i -e "s/user = \x27\x27/user = \x27$DB_USER\x27/g" configuration.php-dist
	sed -i -e "s/password = \x27\x27/password = \x27$DB_PASSWORD\x27/g" configuration.php-dist
	sed -i -e "s/db = \x27\x27/db = \x27$DB_NAME\x27/g" configuration.php-dist
	sed -i -e "s/dbprefix = \x27jos_\x27/dbprefix = \x27$DB_PREFIX\x27/g" configuration.php-dist

	sed -i -e "s/tmp_path = \x27\/tmp\x27/tmp_path = \x27html\/$FOLDER_NAME\/tmp\x27/g" configuration.php-dist
	sed -i -e "s/log_path = \x27\/var\/logs\x27/log_path = \x27html\/$FOLDER_NAME\/administrator\/logs\x27/g" configuration.php-dist

	# Place configuration.php
	cp configuration.php-dist ${HOME}/$WEB_ROOT$FOLDER_NAME
	cd ${HOME}/$WEB_ROOT$FOLDER_NAME
	mv configuration.php-dist configuration.php

	# Function uninstallInstallltaion
	uninstallInstallltaion () {

		rm -rf ${HOME}/$WEB_ROOT$FOLDER_NAME/installation

	}
	while true; do
	printf "\nDo you want to uninstall installation folder:\n"
	read -p "Answer: ([Y] Yes [N] No)." yn
		case $yn in
			[Yy]* ) uninstallInstallltaion; break;;
			[Nn]* ) exit;;
			* ) echo "Please answer yes or no.";;
		esac
	done
}

while true; do
printf "\nDo you want to install $J_VERSION Database and create configuration.php:\n"
read -p "Answer: ([Y] Yes [N] No)." yn
	case $yn in
		[Yy]* ) jinstall; break;;
		[Nn]* ) exit;;
		* ) echo "Please answer yes or no.";;
	esac
done