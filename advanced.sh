sudo ln -sfv ~/dotfiles/programs/tlp /etc/default/tlp
sudo ln -sfv ~/dotfiles/programs/thermal-conf.xml /etc/thermald/thermal-conf.xml
sudo ln -sfv ~/dotfiles/programs/95-monitor-hotplug.rules /etc/udev/rules.d/95-monitor-hotplug.rules
sudo ln -sfv ~/dotfiles/programs/95-keyboard-hotplug.rules /etc/udev/rules.d/95-keyboard-hotplug.rules

sudo udevadm control --reload-rules
