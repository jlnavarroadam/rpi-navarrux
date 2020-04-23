#!/bin/bash

##### ACTUALIZADOR RPI-NAVARRUX - JL NAVARRO ADAM - LICENCIA CC

#### Version 1.1

clear

# INSTALACION DE PAQUETES
apt -y install whois
apt -y install inadyn
apt -y install iptraf-ng
# COPIA DE FICHEROS
cp rpi-navarrux.tgz /tmp
cd /tmp
tar -xvzf rpi-navarrux.tgz
cp -ar /tmp/rpi-navarrux/etc/rc.local /etc/
cp -ar /tmp/rpi-navarrux/root/MENU /root/
cp -ar /tmp/rpi-navarrux/root/bin/* /root/bin/
cp -ar /tmp/rpi-navarrux/root/conf/inadyn.conf /root/conf/
# ELIMINAMOS TEMPORALES
rm -R /tmp/rpi-navarrux
echo ""
echo "Fin."
echo ""
cd /
exit
