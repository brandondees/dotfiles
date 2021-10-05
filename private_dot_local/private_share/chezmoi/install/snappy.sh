# https://forum.snapcraft.io/t/installing-snap-on-opensuse/8375
sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.2 snappy
sudo zypper --gpg-auto-import-keys refresh
sudo zypper dup --from snappy
sudo zypper install snapd
source /etc/profile
sudo systemctl enable --now snapd

