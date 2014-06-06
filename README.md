# Automatic backup script for Wordpress.

## Purpose

This is an automatic backup script to be run from a shell or cron.

This script has to be run onto a directory (the base directory) when one or more Wordpress sites are stored.

The script list the first level directories and, each time it finds a wp-config.php file, 
it parses it to retrieve the DB_NAME, DB_HOST, DB_USER and DB_PASSWORD.

1. It performs a mysqldump of this database
into a backup directory that is given by the wpautobackup.conf file. If
not present, the default backup directory will be the <WWW>/wpBackups directory.

2. (OPTIONNALY with the -c option) It performs a backup of both wp-config.php 
and wp-content directory into a tar file.

The two files have the same name: 

1. one with the .sql.ZIP_SUFFIX suffix (site_name-date.sql.ZIP_SUFFIX)

2. one with the .tar.ZIP_SUFFIX suffix (site_name-date.tar.ZIP_SUFFIX)

Where ZIP_SUFFIX is given into the configuration file.

## Options

### Display of directories
By default, the script will make a backup. It is also possible to make it only
display the name of the directories where a wp-config.php can be found.

To do this use the -d (or --display) optional argument:

    bash mysqlautodumps -d

### Export content of site

Using the -c (or --content) option the script will make a backup of wp-content 
and wp-config.php.


### Call a script after backup
	
It is also possible to make the script automatically call another script after each dump.
	
To do this, edit the $HOME/.wpautobackup/wpautobackup.conf file and append the following:
	
    POST_DUMP_OPERATION=/path/to/executable

The path to the SQL dump is given as an argument to this executable when called.

    

## Internal functioning

Each file will be zipped like this:

    mysqldump --opt -Q --host=$DB_HOST -u $DB_USER --password=$DB_PASSWORD $DB_NAME  | gzip > /path-to-store-the-backup-file/db_backup.sql.gz

The zip compression tool may be given into the wpautobackup.conf file.

<pre><code>BACKUP_DIR=$HOME/wpBackup

ZIP_TOOL=gzip
#DO NOT FORGET to update the suffix accordingly
ZIP_SUFFIX=gz</code></pre>

This script is aimed to be run using _cron_. Be careful of the privileges of the user
who runs the script: he must have write privileges over the BACKUP_DIR

