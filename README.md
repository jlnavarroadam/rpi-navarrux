# rpi-navarrux
"Como bastionar tu casa u oficina con una raspberry pi mediante iptables" - Taller HackMadrid 16-4-2020

Lo primero, instalar en la SD raspbian Lite. Yo utilizo Raspberry Pi Imager. Descarga y ejecuta “raspberry pi imager”, selecciona en Choose OS Raspbian (other), y selecciona Rsapbian Lite. 

Después selecciona el medio a grabar; es decir, tu tarjeta SD. Dale a grabar... Cuando lo tengas, conecta tu rpi por cable a tu router, el cable HDMI al monitor o TV y un teclado usb, y arranca. 

Haz login. Por defecto el usuario es pi, contraseña raspberry. Y ya lo tienes listo para empezar.

Este sistema está diseñado para trabajar con 2 interfaces de red y la wifi integrada en la propia rasberry pi. Por tanto, necesitarás una tarjeta Ethernet con conexión USB para conectarla a tu Rpi. SI tienes una Rpi 4 lleva dos USB 3.0, por lo que obtendrás mayor rendimiento.
Si no dispones de esa tarjeta, no pasa nada. El sistema también permite trabajar con wifi como acceso local (aunque no tendrías posibilidad de conectar a tu red local dispositivos que no tengan interfaz wifi).

¿Cómo instalarlo?

Primero, cambia la contraseña root por defecto. Estando en el usuario pi, teclea:

    sudo passwd root

Luego entra como root:

    su

Ahora, dscarga los dos archivos que hay en el repositorio:

InstalacionRPI.sh
rpi-navarrux.tgz

Copia o clona en tu rpi en la carpeta /opt
  Por ejemplo, ejecuta:
  
    cd /opt
    
    apt-get install git
    
    git clone https://github.com/jlnavarroadam/rpi-navarrux.git
    
    cd rpi-navarrux

Una vez tengas esos archivos, dale permisos de ejecución al archivo .sh:

    chmod +x InstalacionRPI.sh

Y a continuación, ejecuta el programa de configuración de Rasberry Pi:

    raspi-config

Tienes que configurar lo siguiente:
- Network options:Hostname : Pon el nombre de host de tu rpi (deja lo demás de momento)
- Localisation Options: (configura todas las opciones)
  + Change Locale (en mi caso añado es_ES.UTF-8 UTF-8)
  + Change Timezone
  + Change Keyboard Layout (teclado estándar por defecto)
  + Change Wi-fi Country (Selecciona tu país. Si no lo haces, no funcionará la wifi!!!)
- Intrefacing Options:
  + Enable remote command line access to your PI using SSH (activa el servicio SSH!!!)
- Update (actualiza la aplicación raspi-config)

Y ya está.

Una vez lo tengas todo hecho, ya puedes comenzar la instalación:

    cd /opt
    
Si es una nueva instalación ejecuta:

    ./InstalacionRPI.sh

Si quieres actualizar, ejecuta:

    ./update.sh

RECUERDA: 

EL PUERTO DE CONEXIÓN SSH HA QUEDADO CONFIGURADO EN TCP 22022.
DEBERÁS ACCEDER CON EL USUARIO DE CONSOLA QUE TE HA PEDIDO EL PROCESO DE INSTALACIÓN

