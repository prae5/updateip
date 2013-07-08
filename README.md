updateip
========

Bash script to update ClouDNS.net dynamic hostname with your current external ip address.

The script tracks both your old and current exteral ip address, and only updates the ClouDNS.net hostname when your ip changes.

Install the script and set a cronjob to run every 4 hours.


Installation
============
cd /etc/
sudo wget https://raw.github.com/prae5/updateip/master/updateip.sh
sudo chmod a+x updateip.sh
vi updateip.sh
 - Edit CLOUDNS_URL to match the dynamic url provided by ClouDNS.net
 - i.e CLOUDNS_URL="http://ipv4.cloudns.net/api/dynamicURL/?q=7LQ43tl8ZTDsa4ZjVg8o7xa023oVrUQ57LQ43tl8ZTDsa4ZjVg8o7xa023oVrUQ5"
crontab -e 
  - add a line with "0 */4 * * * /etc/updateip.sh >> /dev/null"
  - save and quit crontab editor

The script will now run every 4 hours and updaate ClouDNS.net when required.

You can also manually run the script ./updateip.sh if required

