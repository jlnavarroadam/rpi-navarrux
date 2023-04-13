#!/bin/bash

##### AUTOINSTALADOR RPI-NAVARRUX - JL NAVARRO ADAM - LICENCIA CC

#### Version 1.2

# VERIFICA QUE HAS ACTIVADO EL PAIS EN LA SECCION NETWORK WIFI
clear
echo "Si no has configurado el pais de la wifi, ni activado el servicio ssh, "
echo "cancela con Crtl+C y ejecuta: "
echo "raspi-config"
echo ""
sleep 20
# UPDATE SISTEMA
apt -y update
apt -y upgrade
# USUARIO PI
echo ""
echo "Vamos a cambiar la contraseña del usuario pi..."
passwd pi
# USUARIO DE CONSOLA
local USUARIO
echo ""
echo "Vamos a crear el usuario de consola. Elíjelo tú..."
read -p "Usuario de acceso por consola : " USUARIO
if [[ $USUARIO != "" ]]; then
    adduser $USUARIO
else 
    echo "No hay usuario de consola, cancelando...";
    exit 1
fi
# INSTALACION DE PAQUETES
apt -y install tar
apt -y install whois
apt -y install inadyn
apt -y install figlet
apt -y install dnsutils
apt -y install mc
apt -y install dnsmasq
apt -y install openvpn
apt -y install ntopng
apt -y install hostapd
apt -y install git
apt -y install pip
apt -y install pip2
apt -y install pip
apt -y install pip
apt -y install python
# apt -y install git python-pcapy ### USE PCAPY-NG 
pip3 install pcapy-ng
apt -y install schedtool
apt -y install php
apt -y install postfix
apt -y install iptraf-ng
apt -y install top
apt -y install zip unzip
apt -y install openssl
apt -y install ca-certificates
echo ""
echo "POSTFIX: Si no vas a configurar un servidor de correo, déjalo en"
echo "         servidor de correo local."
sleep 10
echo ""
apt -y install postfix
apt -y install easy-rsa
apt -y install openvpn
# COPIA DE FICHEROS
cp rpi-navarrux.tgz /tmp
cd /tmp
tar -xvzf rpi-navarrux.tgz
cp -ar /tmp/rpi-navarrux/etc/hostapd/* /etc/hostapd/
cp -ar /tmp/rpi-navarrux/etc/default/hostapd /etc/default/hostapd
cp -ar /tmp/rpi-navarrux/etc/maltrail /etc/
cp -ar /tmp/rpi-navarrux/etc/openvpn/keys /etc/openvpn/
cp -ar /tmp/rpi-navarrux/etc/ssh/sshd_config /etc/ssh/
cp -ar /tmp/rpi-navarrux/etc/ssl /etc/
cp -ar /tmp/rpi-navarrux/etc/rc.local /etc/
sed -i 's/sh -e/bash/g' /etc/rc.local
chmod +x /etc/rc.local
chown root:root /etc/rc.local
cp -ar /tmp/rpi-navarrux/etc/crontab /etc/
cp -ar /tmp/rpi-navarrux/etc/*.conf /etc/
cp -ar /tmp/rpi-navarrux/etc/host* /etc/
cp -ar /tmp/rpi-navarrux/etc/issue* /etc/
cp -ar /tmp/rpi-navarrux/etc/mailname /etc/
cp -ar /tmp/rpi-navarrux/etc/motd /etc/
cp -ar /tmp/rpi-navarrux/etc/etc_network_interfaces.d_eth0 /etc/network/interfaces.d/eth0
cp -ar /tmp/rpi-navarrux/etc/lib_systemd_system_maltrail.service /lib/systemd/system/maltrail.service
cp -ar /tmp/rpi-navarrux/root/* /root/
mkdir /home/pi/sftp
mkdir /home/pi/sftp/openvpn
chown root:root /home/pi
chown -R pi:pi /home/pi/sftp
# INSTALACION DE SERVICIOS
echo "Activando hostapd..."
systemctl unmask hostapd
sleep 5
systemctl enable hostapd
systemctl start hostapd
sleep 5
echo "Desactivando apache..."
systemctl stop apache2
systemctl disable apache2
echo "Activando ssh..."
systemctl enable sshd
systemctl start sshd
# INSTALACION MALTRAIL
cd /opt/
git clone https://github.com/stamparm/maltrail.git
sleep 2
systemctl enable maltrail
# ACTUALIZACION REGISTROS CRON
clear
echo ""
echo "Instala estos registros en el crontab del usuario root."
echo "Ejecuta para ello: crontab -e y luego service cron restart"
echo ""
sleep 2
echo "# AUTOINICIO MALTRAIL Y ACTUALIZACION DIARIA"
echo "0 0 * * * root /root/bin/servicemal.sh"
echo "# LIMPIEZA LOGS DE MÁS DE 31 DÍAS"
echo "0 1 1 * * root find /var/log/*.log -mtime +31 -delete"
echo "0 1 1 * * root find /var/log/maltrail/* -mtime +31 -delete"
echo "0 1 1 * * root find /var/log/ntopng/* -mtime +31 -delete"
echo "# LIMPIEZA DE BACKUPS LOGS SEMANAL LOS DOMINGOS 7:00"
echo "0 7 * * 7 root find /var/log/*.gz -delete"
echo "# EJECUCION CADA MINUTO DE AUTODROP.PHP"
echo "* * * * * root /root/bin/autodrop.php > /dev/null"
# ELIMINAMOS TEMPORALES
rm -R /tmp/rpi-navarrux
echo ""
echo "Fin."
echo ""
cd /
exit
