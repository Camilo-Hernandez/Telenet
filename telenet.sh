#!/bin/bash

opcion=$(whiptail --title 'Menu Telnet' --fb \
--menu "      ===================== \n              TELNET \n             ====================== \n Por Camilo Hernández Ruiz \n camilo.hernandez1@udea.edu.co \n Servicios Telemáticos \n Ingneiería de Telecomunicaciones \n Universidad de Antioquia \n Semestre 2022 \n " \
30 40 5 \
"1" "Información de red" \
"2" "Consulta DNS" \
"3" "Velocidad de conexión" \
"4" "Salir" 3>&1 1>&2 2>&3)
echo La opción es: $opcion