
#!/bin/bash
# Menu shell script info del sistema
# Linux server / desktop.

# Definiendo variables
LSB=/usr/bin/lsb_release

# Vemos el mensaje en pausa
# $1-> Mensaje (opcional)
function pause(){
	local message="$@"
	[ -z $message ] && message="Pulsa [Enter] para continuar..."
	read -p "$message" readEnterKey
}

# Función - Ver el menú principal en pantalla
function show_menu(){
    date
    echo "---------------------------"
    echo "  UTILIDADES DEL SISTEMA  "
    echo "---------------------------"
	echo "1. Informacion del S.O."
	echo "2. Informacion del Hostname y DNS"
	echo "3. Informacion de la Red"
	echo "4. Usuarios conectados"
	echo "5. Ultimos usuarios conectados"
	echo "6. Informacion de la memoria"
	echo "7. Actualización del sistema"
	echo "8. Copia Seguridad Documentos"
	echo "9. Salir"
}

# Función - Ver el mensaje de cabecera
# $1 - message
function write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}

# Función - Obtengo información sobre el sistema operativo
function os_info(){
	write_header " Información del sistema "
	echo "Sistema Operativo : $(uname)"
	[ -x $LSB ] && $LSB -a || echo "$LSB no está instalado (set \$LSB variable)"
	#pause "Pulsa [Enter] para continuar..."
	pause
}

# Función - Obtengo información sobre DNS, IP y hostname
function host_info(){
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	pause
}

# Función - Información sobre interfaces de red
function net_info(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Informacion de la Red "
	echo "Interfaces de red encontrados : $(wc -w <<<${devices})"

	echo "*** Información sobre direcciones  IP  ***"
	ip -4 address show

	echo "***********************"
	echo "*** Enrutamiento de Red ***"
	echo "***********************"
	netstat -nr

	echo "**************************************"
	echo "*** Interface de la información del tráfico ***"
	echo "**************************************"
	netstat -i

	pause 
}

# Función - Ver una lista de los usuarios logueados 
#             Ver una lista de los usuarios recientemente logueados   
function user_info(){
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Quién está online "; who -H; pause ;;
		last) write_header " Lista de los últimos usuarios logueados "; last ; pause ;;
	esac 
}

# Función - Obtener información sobre la memoria usada y libre
function mem_info(){
	write_header " Free and used memory "
	free -m
    
    echo "*********************************"
	echo "*** Estadísticas de la Memoria Virtual ***"
    echo "*********************************"
	vmstat
    echo "***********************************"
	echo "*** Los procesos que más memoria consumen ***"
    echo "***********************************"	
	ps auxf | sort -nr -k 4 | head -5	
	pause
}

# Función - Actualizar sistema operativo 
  
function system_update(){

echo "*****************************************************"
echo "Inicio de actualización `date '+%Y-%m-%d %H:%M:%S'`"
echo "*****************************************************"
 
# Actualización y limpieza del sistema

sudo apt-get update; sudo apt-get upgrade -y
 
# DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
 
# (apt-get autoremove -y &amp;&amp; apt-get clean -y)
 
echo "*****************************************************"
echo "Fin de actualización `date '+%d-%m-%Y %H:%M:%S'`"
echo "*****************************************************"

cat /etc/*-release	

read -rsp $'Pulsa Enter para continuar...\n'


}



# Función - Crear backup en una carpeta cuyo nombre es la fecha y la hora del sistema 
function copiaseg(){

if [ ! -d $/Backup ]
	then 
#     El directorio no existe
	sudo mkdir /Backup
echo "Se ha creado el directorio Backup"
read -rsp $'Pulsa Enter para continuar...\n'
	else
echo "El Directorio Backup ya existe"	
read -rsp $'Pulsa Enter para continuar...\n'
fi

if [ ! -d $/Backup/neo ]
	then  
# el directorio de usuario no existe
	sudo mkdir /Backup/$USER
echo "El directorio de usuario no existe"
read -rsp $'Pulsa Enter para continuar...\n'
else
echo "El directorio de usuario ya existe"
read -rsp $'Pulsa Enter para continuar...\n'


         
fi


sudo cp -a ~/Documentos /Backup/$USER/$(date +%d%m%Y-%H%M)

echo "*****************************************************"
echo "Copia de seguridad realizada `date '+%d-%m-%Y %H:%M:%S'`"
echo "*****************************************************"

read -rsp $'Pulsa Enter para continuar...\n'


}


# Función - Ejecución de una opción de menú utilizando case..esac 
function read_input(){
	local c
	read -p "Elige una opción [ 1 - 9 ] " c
	case $c in
		1)	os_info ;;
		2)	host_info ;;
		3)	net_info ;;
		4)	user_info "who" ;;
		5)	user_info "last" ;;
		6)	mem_info ;;
		7)	system_update ;;
		8)	copiaseg ;;
		9)	echo "Adiós"; exit 0 ;;
		*)	
			echo "Por favor, elige un número entre 1 y 9. No seas TROLL"
			pause
	esac
}

# ignore CTRL+C, CTRL+Z and quit singles using the trap
trap '' SIGINT SIGQUIT SIGTSTP

# main logic
while true
do
	clear
 	show_menu	# display memu
 	read_input  # wait for user input
done
