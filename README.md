# debian-9-kiosk-sign
Script that automatically configures a locked-down debian 9 kiosk or digital sign single full screen browser application from minimal iso with chrome (else chromium), unattended updates, sshd and fail2ban 

## Install Debian 9 minimal ISO from bootable USB drive
* Download netboot mini.iso from Debian around 40mb
* Create a bootable USB drive
* Insert USB drive into computer
* Enter BIOS and select boot from USB
* On Language Selection Screen remove USB drive 
* Set root password, create user with userName, set timezone.
* Under Software Selection uncheck all software.
* Once the installation is finished login as root
* Download and run configure script by typing...

```
wget http://go.easysigns.online/configure-kiosk-sign.sh
chmod u+x configure-kiosk-sign.sh
# configure-kiosk-sign.sh userName browserUrl screenRotation
./configure-kiosk-sign.sh easysigns http://yoursite.com screenRotation
```
userName is the user created during install.  
browserUrl is what will be displayed in browser.  
screenRotation is optional: normal, left, right, or inverted.  
  
When done, system will reboot.  
Upon startup system logs in as user and displays url in browser full screen.
