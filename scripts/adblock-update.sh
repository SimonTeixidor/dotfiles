#!/bin/sh

cp /etc/hosts.head /tmp/hosts
curl https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts |
	grep "^0.0.0.0" >> /tmp/hosts
cp /tmp/hosts /etc/
