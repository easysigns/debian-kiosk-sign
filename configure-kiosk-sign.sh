#!/bin/sh
USER=$1
ESOHOME=/usr/share/easysignsonline
SYSBIN=/usr/bin
DIRECTORY=/tmp/easysignsonline-install
CLASSFILE=/tmp/easysignsonline-install/EasySignsOnline.class
SCRIPTFILE=/tmp/easysignsonline-install/easysignsonline
OPENBOXDIR=/home/$USER/.config/openbox/
ARCHITECTURE=`dpkg --print-architecture`

if [ -z "$USER" ]
then
  echo "Error - first parameter username is required"
  return
fi

# Get Files
mkdir -p $DIRECTORY
cd $DIRECTORY

if [ ! -f $SCRIPTFILE ]
then
  wget https://easysigns.online/easysignsonline
fi

# Update and load system
if [ $ARCHITECTURE = "amd64" ]; then
  echo AMD64
  apt-get update
  apt-get -y install xorg openbox lightdm sudo openssh-server unattended-upgrades apt-listchanges fail2ban
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
  apt-get update
  apt-get -y install google-chrome-stable
else
  echo not AMD64
  apt-get update
  apt-get -y install xorg openbox lightdm sudo openssh-server unattended-upgrades apt-listchanges chromium fail2ban
  ln -s /usr/bin/chromium /usr/bin/google-chrome
fi

# Make user autologin
sed -i "/#autologin-user=/s/.*/autologin-user=$USER/" /etc/lightdm/lightdm.conf

# Turn off screen saver power save
sed -i '/#xserver-command=X/s/.*/xserver-command=X -s 0 dpms/' /etc/lightdm/lightdm.conf

# Create openbox directory for user if doesn't exist
sudo -u $USER mkdir -p $OPENBOXDIR

# disable right click, run eso controller
sudo -u $USER echo "xmodmap -e \"pointer = 1 12 11 10 9 8 7 6 5 4 3 2\" &"  >> $OPENBOXDIR/autostart
sudo -u $USER echo "easysignsonline &" >> $OPENBOXDIR/autostart

# Unattended Upgrades Settings
sed -i '/\/\/Unattended-Upgrade::Remove-Unused-Dependencies "false";/s/.*/Unattended-Upgrade::Remove-Unused-Dependencies "true";/' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/\/\/Unattended-Upgrade::Automatic-Reboot "false";/s/.*/Unattended-Upgrade::Automatic-Reboot "true";/' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i '/\/\/Unattended-Upgrade::Automatic-Reboot-WithUsers "true";/s/.*/Unattended-Upgrade::Automatic-Reboot-WithUsers "true";/' /etc/apt/apt.conf.d/50unattended-upgrades

if [ $ARCHITECTURE = "amd64" ]; then
  # Add Google to unattended upgrades
  sed -i '/Unattended-Upgrade::Origins-Pattern {/s/.*/Unattended-Upgrade::Origins-Pattern { \"origin=Google\\, Inc.,suite=stable,label=Google\";/' /etc/apt/apt.conf.d/50unattended-upgrades
fi

# Add user a sudoer
echo $USER '  ALL=(ALL:ALL) ALL' >> /etc/sudoers

# Easy Signs Online
mkdir -p $ESOHOME
cp $SCRIPTFILE $SYSBIN/easysignsonline
chmod ugo+x $SYSBIN/easysignsonline

# Is browser url defined?
if [ ! -z "$2" ]
then
  rm -rf $ESOHOME/config.properties
  echo "url="$2 | sed 's/:/\\:/g' >> $ESOHOME/config.properties
fi

if [ ! -z "$3" ]
then
  rm -rf $ESOHOME/config.properties
  echo "rotate="$3 >> $ESOHOME/config.properties
fi

# Reboot
reboot

