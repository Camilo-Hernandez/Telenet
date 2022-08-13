#!/bin/bash

opcion=$(whiptail --title 'Menu Telnet' --fb \
--menu "      ===================== \n              TELNET \n             ====================== \n Por Camilo Hernández Ruiz \n camilo.hernandez1@udea.edu.co \n Servicios Telemáticos \n Ingeniería de Telecomunicaciones \n Universidad de Antioquia \n Semestre 2022-1 \n " \
30 40 5 \
"1" "Información de red" \
"2" "Consulta DNS" \
"3" "Velocidad de conexión" \
"4" "Salir" 3>&1 1>&2 2>&3)
echo La opción es: $opcion

case $opcion in
    1)
        ip=$(ifconfig enp0s3 | awk 'NR==2 {print $2}')
        mask=$(ifconfig enp0s3 | awk 'NR==2 {print $4}')
        gw=$(ip r | awk 'NR==1 {print$3}')
        dns_ip=$(grep "nameserver" /etc/resolv.conf | awk 'NR==1 {print $2}')
        dns_name=$(grep "nameserver" /etc/resolv.conf | awk 'NR==1 {print $2}' | nslookup | awk 'NR==1 {print $4}')
        whiptail --title "Opcion 1: Información de red" --msgbox "IP: $ip\nMASK: $mask\nGW: $gw\nDNS: $dns_ip cuyo nombre de dominio es $dns_name" 20 40 2
esac