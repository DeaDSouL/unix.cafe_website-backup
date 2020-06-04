#!/usr/bin/bash
# -----------------------------------------------------------------------------------
# Author:   DeaDSouL (Mubarak Alrashidi)
# URL:      https://unix.cafe/wp/en/2020/06/how-to-backup-your-website-from-terminal/
# GitHub:   https://github.com/DeaDSouL/unix.cafe_website-backup
# Twitter:  https://twitter.com/_DeaDSouL_
# License:  GPLv3
# -----------------------------------------------------------------------------------
# This file should be on your local computer.
# -----------------------------------------------------------------------------------

# configuration
SRV_USER='your_username'
SRV_HOST='your_server_host'
SRV_BKP_SCRIPT='path_to_bkp_on_server'
SRV_BACKUPS_DIR='path_to_backups_on_server' # must ends with trailing slash
LOCAL_ARCHIVE_DIR='path_to_local_archive' # must ends with trailing slash

# ask bkp on server to take a backup
ssh -t $SRV_USER@$SRV_HOST "$SRV_BKP_SCRIPT"

# download the taken backup
rsync -avhPe 'ssh' $SRV_USER@$SRV_HOST:"$SRV_BACKUPS_DIR" "$LOCAL_ARCHIVE_DIR"
