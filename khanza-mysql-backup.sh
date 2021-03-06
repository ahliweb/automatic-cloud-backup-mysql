#!/bin/bash

#####################################################################
# 	Use this script to perform backups of one or more MySQL databases.
#	originally downloaded from https://gist.github.com/chill117/6243212
#	modified by unggul@ahliweb.com on 2019-12-27
#####################################################################

#####################################################################
# Set some configuration bellow first
#####################################################################

# Databases that you wish to be backed up by this script. You can have any number of databases specified; 
# encapsilate each database name in single quotes and separate each database name by a space.
# Example: 
# databases=( '__DATABASE_1__' '__DATABASE_2__' )
databases=('your-db')

# The host name of the MySQL database server; usually 'localhost'
db_host="localhost"

# The port number of the MySQL database server; usually '3306'
db_port="3306"

# The MySQL user to use when performing the database backup.
db_user="root"

# The password for the above MySQL user.
db_pass="your-password"

# Directory to which backup files will be written. Should end with slash ("/").
backups_dir="/home/your-direktory/Khanza/Backup/"

# User to perform backup command
backups_user="root"

# Retency to keep your backup files
longdays="60"

#####################################################################
# don't change script bellow unles you know what you do
#####################################################################

# Date/time included in the file names of the database backup files.
datetime=$(date +'%Y-%m-%d-T%H-%M-%S')

for db_name in ${databases[@]}; do
        # Create database backup and compress using gzip.
        mysqldump -u $db_user -h $db_host -P $db_port --password=$db_pass $db_name | gzip -9 > $backups_dir$db_name--$datetime.sql.gz
done

# Set appropriate file permissions/owner.
chown $backups_user:$backups_user $backups_dir*--$datetime.sql.gz
chmod 0644 $backups_dir*--$datetime.sql.gz

# Delete files older than $longdays
find $backups_dir/* -mtime +$longdays -exec rm {} \;

#####################################################################
# done for backup databases
#####################################################################

# add some automatic steps
#####################################################################
# add to crontab, follow these step :
# 1. save this file to .sh file extention
# 2. add chmod +X (execute) to this file
# 3. open crontab as specified with your operating system. 
#    type on terminal : sudo crontab -e (on linux mint will open nano as editor)
# 4. set your crontab configuration
#    then add time specific :
#    as example, to run schedule execution 3 times daily please change minute and hour bellow,
#    5 1 * * * /home/harapaninsani/Khanza/Update/khanza-mysql-backup.sh
#    5 9 * * * /home/harapaninsani/Khanza/Update/khanza-mysql-backup.sh
#    5 17 * * * /home/harapaninsani/Khanza/Update/khanza-mysql-backup.sh
# 5. save your crontab configuration by press ctrl + o then press enter. to exit pres ctrl + x 
# 6. done
#####################################################################

#####################################################################
# add to google drive / onedrive (cooming soon), follow these step :
# 1. create a google drive account
# 2. download insync from http://bit.ly/insync-cloud or alternate free https://liberodark.github.io/ODrive/ 
# 3. install to your gui os
# 4. change some configuration
# 5. done 
#####################################################################
