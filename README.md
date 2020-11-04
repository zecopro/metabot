# metabot
metabot it's simple bash script using masscan and cron job and metasploit to find vulnerability hosts scheduling







# usege

metabot mix between cron job and metasploit and masscan

in this line in bash script :
(masscan  -p #target_port 0.0.0.0/0 --rate=99999 --exclude 255.255.255.255 -oX smb.xml)
we use masscan with port he have vulnerability in metasploit like smb port "445" a most vulnerability Spread its ms17_010 and we hvae auxiliary module scanner in metasploit we can scanning lots hosts like "4,000,000" opening ports 445 with range "0.0.0.0/0" this means scan all ips world with rate "99999" here you need bandiwth with rate at least 30m upload
 

in this line in bash script :
(cat /var/.,/smb.xml | grep addr | cut -d '"' -f 4 > /var/.,/ips.txt) 
here i use cat and grep and cut to do filtering for lists ips from smb.xml to plain text ip "ips.txt"

in this line in bash script :
(msfconsole -x 'setg RHOSTS file:ips.txt; setg THREADS 400; setg RPORT #target_port; use #auxiliary_meta_module_to_find_hosts_vulberability; run; exit;')
we use metasploit with multi commands with option -x 
"setg RHOSTS file:ips.txt" : this command for set file name ips.txt from previous line in bash for all modules in metasploit
"setg THREADS 400" : here we use threads to speed a more hosts in same time but make sure you enough space from memory 
"setg RPORT #target_port" : here set port in #target_port to scanning him for all modules 
"use #auxiliary_meta_module_to_find_hosts_vulberability" : here use module name do you need usege like auxiliary/scanner/smb/smb_ms17_010
"run" : run module 
"exit" : quit from metasploit 
all hosts vulerabilit its saved in database in hosts command and make sure you run database and msfdb (service postgresql start && msfdb init)

now we cat use script with cronjob to scheduling every time you need 
to add schedule for starting script use this command "crontab -e" and you can add new schedule like 
"0 9 * * * /root/metabot.sh" this mean in crontab start script every day At the hour 9 AM 
"0 */35 * * * /root/metabot.sh" this mean in crontab start script every 35 hour Carelessly time date 
you can use multi scheduling with site crontab
"https://crontab.guru/"
