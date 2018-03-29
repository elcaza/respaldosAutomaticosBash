#!/bin/bash

# Respaldo automatizado V1
# @author henkerLove

# Genera el archivo tar que será el respaldo
# @param 1 <ARG_TAR>
# @param 2 <EXTENSION>
# @param 3 <RUTA_A_RESPALDAR>
function generaTar(){
	#ARG_TAR="-zcvpf"; #Compresion min	 	.gzip
	#ARG_TAR="-jcvpf"; #Compresion med  	.bz2
	#ARG_TAR="-Jcvpf"; #Compresión max 		.xz

	#EXTENSION=".tar.gzip";
	#EXTENSION=".tar.bz2";
	#EXTENSION=".tar.xz";

	#RUTA_A_RESPALDAR="/home/user/";

	#tar $1 respaldo-`date +%d%m%Y`$2 $3 > log`date +%d%m%y`.txt
	tar $1 respaldo`date +%d%m%Y`$2 $3 > log`date +%d%m%y`.txt 2>&1
}

# Define los parametros del archivo a comprimir
# @param 1 <ruta> /home/
# @param 2 <compresion> | |min|med|max
function generaRespaldo(){
	RUTA=$1
	COMPRESION=$2
	ARGS="-cpvf"
	EXT=".tar"
	
	if [ -d $RUTA ] || [ -e $RUTA ]; then
		echo "La ruta es: "$RUTA

		if [ -z $COMPRESION ]; then
			echo "Sin compresion"
		elif [ $COMPRESION = "min" ]; then 
			echo "Compresion min"
			ARGS="-zcvpf"
			EXT=".tar.gzip"
		elif [ $COMPRESION = "med" ]; then 
			echo "Compresion media"
			ARGS="-jcvpf"
			EXT=".tar.bz2"
		elif [ $COMPRESION = "max" ]; then
			echo "Compresion max"
			ARGS="-Jcvpf"
			EXT=".tar.xz"
		else
			echo "Error"
		fi 

		echo $ARGS 
		echo $EXT
		echo $RUTA

		generaTar $ARGS $EXT $RUTA
	else 
		echo "* Ruta invalida"
		echo "<script> <ruta> <compresion>"
		echo "	--Ejemplo: ./respaldo.sh /home/user | |min|med|max"
	fi 
}

generaRespaldo $1 $2