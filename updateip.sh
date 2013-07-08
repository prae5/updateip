#!/bin/bash
: '
/*
 *      Copyright (C) 2008-2013 Paul Rae
 *      http://www.paulrae.com
 *
 *  This Program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This Program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  If not, see <http://www.gnu.org/licenses/>
 *
 *
 *  duplicitybackup.sh is a script for managaing duplicity backups.
 *  It provivides an easy mechanism for creating, backingup, restoring,
 *  deleting and uploading encrypted backups using duplicity and ncftp
 *
 *  Project     : updateip.sh
 *  Git Repo    : https://github.com/prae5/updateip
 *  Project Site: 
 *  Author      : Paul Rae
 *  Email       : paul@paulrae.com
 *  Website     : www.paulrae.com
 */
'

# Run this script every 4 hours from a cronjob to ensure your external ip address is updaged regulary
# Example cron entry:
# 0 */4 * * * /etc/updateip.sh >> /dev/null

#cloudns dynamic update url
CLOUDNS_URL="PUT YOUR UPDATE URL HERE"

#check if tmp file exists, if not create
if [ ! -f /tmp/external.ip ]; then
    echo "Temp file not found - creating"
    echo 0.0.0.0 > /tmp/external.ip
fi

OLDIP=`cat /tmp/external.ip`
CURRENTIP=`curl ifconfig.me`

if [ "$CURRENTIP" = "$OLDIP" ]; then
   echo "IP not changed since last check ($OLDIP) - no update required"
else
   echo "IP Changed - Old IP: $OLDIP - New IP: $CURRENTIP"
   echo $CURRENTIP > /tmp/external.ip
   #update ip with cloudns.net
   curl $CLOUDNS_URL
fi
