#!/bin/bash

# Config para Respaldo automatizado V1
# @author henkerLove

# ****************************CRON **************************
# Para automatizar mediante cron se puede ocupar el comando 
# sudo nano /etc/crontab
# luego añadir las siguientes líneas
# <min> <hora> <diaDelMes> <mes> <diaDeLaSemana> <user> </rutaDelScript/script.sh>
# Ejemplo: 00 21 * * * user /ruta/configRespaldo.sh
# ***********************************************************

CARPETA_RESPALDOS="/home/`whoami`/respaldos" #contendra los respaldos realizados
RUTA_SCRIPT="/ubicacion/respaldo.sh" #ubicacion del script
CARPETA_A_RESPALDAR="/carpeta/" #carpeta que sera respaldada
COMPRESION="" #| |min|med|max| Tipo de compresion <niguna> <gzip> <bz2> <xz> Comprobar que lo soporta tu S.O

if [ -d $CARPETA_RESPALDOS ]; then
	echo "Existe carpeta"
else
	mkdir $CARPETA_RESPALDOS
	#echo "Se ha creado carpeta"
fi

cd $CARPETA_RESPALDOS

if [ -e $RUTA_SCRIPT ] && [ ! -x $RUTA_SCRIPT ]; then
	echo "Existe el archivo"
	chmod +x $RUTA_SCRIPT
elif [ ! -e $RUTA_SCRIPT ]; then 
	echo "No se encuentra el script" 
	echo "No se encuentra el script" >> logError.txt
fi

( exec $RUTA_SCRIPT $CARPETA_A_RESPALDAR $COMPRESION )