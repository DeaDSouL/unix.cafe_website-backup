#!/usr/bin/bash
# -----------------------------------------------------------------------------------
# Author:   DeaDSouL (Mubarak Alrashidi)
# URL:      https://unix.cafe/wp/en/2020/06/how-to-backup-your-website-from-terminal/
# GitHub:   https://github.com/DeaDSouL/unix.cafe_website-backup
# Twitter:  https://twitter.com/_DeaDSouL_
# License:  GPLv3
# -----------------------------------------------------------------------------------
# This file should be on your remote server (website server)
# -----------------------------------------------------------------------------------

# configuration
DSTDIR="/path/to/where/to/store/backups"
SRCDIR="/path/to/what/to/backup"
DBNAME='db-name'
DBUSER='db-user'
DBPASS='db-pass'

# ------------------------------------------------------------------------------------------
# You don't have to modify anything else below this line, unless you know what you're doing
# ------------------------------------------------------------------------------------------

# prepare sub-directory name
DATE=$(date +'%Y%m%d')
TIME=$(date +'%H%M%S')
SUBDIR="${DSTDIR}/${DATE}"
DIRNAME=$(basename "$SRCDIR")

# create the sub-directory
[[ -e "${SUBDIR}" ]] && SUBDIR="${SUBDIR}-${TIME}"
mkdir -p "${SUBDIR}"

# backing up files
echo -e '\n * Backing up files …'; sleep 2
tar -zcpf "${SUBDIR}/${DIRNAME}.tar.gz" "$SRCDIR"

# backing up db
echo -e '\n * Backing up database …\n'; sleep 2
mysqldump ${DBNAME} -u ${DBUSER} -p${DBPASS} > "${DBNAME}.sql"
tar -zcpf "${SUBDIR}/${DBNAME}.sql.tar.gz" "${DBNAME}.sql"
rm -f "${DBNAME}.sql"
