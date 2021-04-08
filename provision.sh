#!/usr/bin/env bash

cat > /etc/hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

192.168.33.11 server1.vagrant.internal server1
192.168.33.12 server2.vagrant.internal server2
EOF
