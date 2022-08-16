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
        ;;
    2)
        input=$(whiptail --title "Opción 2: Consulta DNS" --inputbox "Escribe la IP o el nombre de dominio del DNS" 8 39 3>&1 1>&2 2>&3 )
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            consulta=$(nslookup $input)
            whiptail --title "Opción 2: Consulta DNS" --msgbox "$consulta" 18 30
        else
            whiptail --msgbox "Usuario canceló la consulta." 8 20
        fi
        ;;
    3)
        input=$(whiptail --title "Opción 3: Velocidad de conexión" --inputbox "Escribe la IP o el nombre de dominio del sitio web" 8 41 3>&1 1>&2 2>&3 )
        exitstatus=$?
        if [ $exitstatus = 0 ]; then
            avg_t=$(ping -c16 -q $input | awk -F/ '/rtt/ {print $5}')
            avg_t2=$(awk -v var1=$avg_t -v var2=2 'BEGIN { print  ( var1 / var2 ) }')
            distancia=$(awk -v var1=$avg_t -v var2=300 'BEGIN { print  ( var1 * var2 ) }')
            num_bytes=$(ping -c2 -q google.com | awk 'NR==1 {print $4}')
            num_bits=$(($num_bytes*8))
            tasa_bps=$(awk -v var1=$num_bits -v var2=$avg_t2 'BEGIN { print  ( var1 / var2 ) }')
            whiptail --title "Opción 3: Velocidad de conexión" --msgbox "Velocidad de la luz: 300.000 Km/s \nRetardo promedio: $avg_t2 ms \nDistancia al servidor web: $distancia Km \nNúmero de bits enviados: $num_bits bits\nTasa de transferencia: $tasa_bps bps" 20 60
        else
            whiptail --msgbox "Usuario canceló la consulta." 8 20
        fi
        ;;
esac
