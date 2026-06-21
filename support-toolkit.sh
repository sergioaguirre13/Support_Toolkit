#!/bin/bash

# ===================================
# Support Toolkit
# Descripción:
# Herramienta de soporte técnico para
# consultar información del sistema.
# ===================================

LOG="support-toolkit.log"

red="\e[31m"
green="\e[32m"
blue="\e[34m"
yellow="\e[33m"
reset="\e[0m"

registrar_log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG"
}

pausa() {
    read -p "Presione ENTER para continuar..."
}

mostrar_menu() {
    echo -e "${blue}== TOOLKIT DE SOPORTE TECNICO ==${reset}"
    echo ""
    echo "1) Ver IP"
    echo "2) Ver uso de disco"
    echo "3) Ver RAM"
    echo "4) Ver usuarios conectados"
    echo "5) Hacer ping"
    echo "6) Reiniciar servicio"
    echo "7) Ver procesos"
    echo "8) Ver Logs"
    echo "9) Salir"
    echo ""
}

mostrar_logs() {
    echo ""
    registrar_log "ver logs"

    echo -e "${yellow}=== LOGS DEL SISTEMA ===${reset}"
    cat "$LOG"

    echo ""
}

mostrar_ip() {
    echo ""
    registrar_log "mostrar ip"

    echo -e "${green}=== IP DEL EQUIPO ===${reset}"
    hostname -I | awk '{print $1}'

    echo ""
}

mostrar_ram() {
    echo ""
    registrar_log "mostrar ram"

    echo -e "${blue}=== MEMORIA RAM ===${reset}"
    free -h

    echo ""
}

mostrar_disco() {
    echo ""
    registrar_log "mostrar disco"

    echo -e "${yellow}=== USO DE DISCO ===${reset}"
    df -h

    echo ""
}

mostrar_usuarios() {
    echo ""
    registrar_log "mostrar usuarios"

    echo -e "${green}=== USUARIOS CONECTADOS ===${reset}"
    who

    echo ""
}

hacer_ping() {
    echo ""

    read -p "Ingrese IP o dominio: " destino

    registrar_log "ping a $destino"

    echo -e "${blue}=== PING A $destino ===${reset}"
    ping -c 4 "$destino"

    echo ""
}

mostrar_procesos() {
    echo ""
    registrar_log "mostrar procesos"

    echo -e "${yellow}=== PROCESOS DEL SISTEMA ===${reset}"
    ps aux | head -20

    echo ""
}

reiniciar_servicio() {
    echo ""

    read -p "Nombre del servicio: " servicio

    registrar_log "reiniciar servicio $servicio"

    sudo systemctl restart "$servicio"

    echo -e "${green}Servicio reiniciado.${reset}"

    echo ""
}

while true
do
    clear

    mostrar_menu

    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            mostrar_ip
            pausa
            ;;
        2)
            mostrar_disco
            pausa
            ;;
        3)
            mostrar_ram
            pausa
            ;;
        4)
            mostrar_usuarios
            pausa
            ;;
        5)
            hacer_ping
            pausa
            ;;
        6)
            reiniciar_servicio
            pausa
            ;;
        7)
            mostrar_procesos
            pausa
            ;;
        8)
            mostrar_logs
            pausa
            ;;
        9)
            echo -e "${green}Saliendo del programa...${reset}"
            exit 0
            ;;
        *)
            echo ""
            echo -e "${red}Opción inválida${reset}"
            echo ""
            pausa
            ;;
    esac
done