# debian-9-kiosk-sign
Script that automatically configures a locked-down debian 9 kiosk or digital sign single full screen browser application from minimal iso with chrome (else chromium), unattended updates, sshd and fail2ban 

## Install Debian 9 minimal ISO from bootable USB drive
* Download netboot mini.iso from Debian around 40mb
* Create a bootable USB drive
* Insert USB drive into computer
* Enter BIOS and select boot from USB
* On Language Selection Screen remove USB drive 
* Partions select Guided entire hard drive
* Set root password, create user, set timezone.
* Under Software Selection uncheck all software.
* Once the installation is finished login as root
* Download and run configure script by typing...

```
wget http://go.easysigns.online/configure-kiosk-sign.sh
chmod u+x configure-kiosk-sign.sh
# configure-kiosk-sign.sh user url rotation
./configure-kiosk-sign.sh easysigns https://easysigns.online/v/123456790987654321 inverted
```
user created during install  
url is what to be displayed in browser  
rotation rotates screen (optional): normal, left, right, inverted  
  
When configure script is done, the system will reboot.  
Upon startup, the system logs in as user and displays url in browser full screen.
  
The file /usr/share/easysignsonline/config.properties contains properties url and rotate.

