#!/bin/bash 

masscan  -p #target_port 0.0.0.0/0 --rate=99999 --exclude 255.255.255.255 -oX smb.xml

sleep 5

cat smb.xml | grep addr | cut -d '"' -f 4 > ips.txt 

msfconsole -x 'setg RHOSTS file:ips.txt; setg THREADS 400; setg RPORT #target_port; use #auxiliary_meta_module_to_find_hosts_vulberability; run; exit;'

exit
