#!/bin/sh -x

sudo rsync -r --delete bind /etc/
sudo /etc/init.d/bind9 restart
