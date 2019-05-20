# configure kiosk sign
This script configures a locked-down Debian 9 (or Raspbian) kiosk or digital sign single full screen browser application from minimal iso with chrome (else chromium), screen rotation, unattended updates, sshd and fail2ban 

## For Raspberry Pi 3 Raspbian Install
* Follow instructions https://www.raspberrypi.org/downloads/raspbian/ minimal install
* Log in as pi
* Type: sudo adduser easysigns
* Download and run configure-kiosk-sign.sh script (see below)

## For Debian 9 minimal ISO Install from bootable USB drive
* Download Debian OS tiny netboot mini.iso https://www.debian.org/distrib/netinst
* Create a bootable USB drive
* Insert USB drive into computer
* Enter BIOS and select boot from USB
* On Language Selection Screen remove USB drive 
* Partitions: select Guided entire hard drive
* Set root password, create user, set timezone.
* Under Software Selection uncheck all software.
* Once the installation is finished login as root
* Download and run configure-kiosk-sign.sh script by typing...

```
wget http://go.easysigns.online/configure-kiosk-sign.sh
chmod u+x configure-kiosk-sign.sh
sudo ./configure-kiosk-sign.sh easysigns https://easysigns.online/v/123456790987654321 normal
```
sudo ./configure-kiosk-sign.sh user url rotation 
  
user created during install. The user to be logged in to launch full screen chrome.  
url is what to be displayed in browser  
rotation rotates screen (optional): normal, left, right, inverted  
  
When configure script is finished, the system will reboot.  
Upon startup, the system logs in as user and displays url in browser full screen.
  
The file /usr/share/easysignsonline/config.properties contains properties url and rotate.

