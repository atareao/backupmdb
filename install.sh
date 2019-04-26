#!/bin/bash
if [ "$EUID" -ne 0 ]
then
	echo You must run this script as root
else
	echo Creating directories
	mkdir -p /var/opt/mariadb
	mkdir -p /opt/backupmdb
	echo Copying files
	cp backupmdb.sh /opt/backupmdb/
	cp .telegram_keys /root/
	cp .my.cnf /root
	cp backupmdb.service /lib/systemd/system/
	cp backupmdb.timer /lib/systemd/system/
fi
