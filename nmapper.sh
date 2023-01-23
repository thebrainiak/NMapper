#!/bin/bash

echo -e "\n NMAPPER v1.0 \n"

read -p "Introduce la IP a escanear: " host
read -p "Introduce el dominio a escanear (En caso de no necesitarlo dejarlo en blanco): " dominio


            echo -e "\n [*] 1. Realice el descubrimiento de host en toda la red.\n"
            echo -e "\n [*] 2. Realice un escaneo SYN con detección de versión y scripts predeterminados contra un host.\n"
            echo -e "\n [*] 3. Igual que el anterior pero contra los 100 mejores puertos\n"
            echo -e "\n [*] 4. Realice una exploración UDP contra un host dado.\n"
            echo -e "\n [*] 5. Realizar la detección del sistema operativo contra un host.\n"
            echo -e "\n [*] 6. Realizar un escaneo de CVE conocidos.\n"
            echo -e "\n [*] 7. Realice la enumeración de SMB en un host para identificar los recursos compartidos abiertos, la versión de SMBV y más.\n"
            echo -e "\n [*] 8. Realice un análisis para identificar vulnerabilidades conocidas en SMB.\n"
            echo -e "\n [*] 9. Realizar una transferencia de zona DNS contra un host.\n"
            echo -e "\n [*] 10. Realizar una fuerza bruta de credenciales de FTP.\n"
            echo -e "USO:Introduce tus listas en los archivos users.txt y passwords.txt en el directorio de este script."
            echo -e "\n [*] 11. Realizar una fuerza bruta de credenciales HTTP\n"
            echo -e "USO:Introduce tus listas en los archivos users.txt y passwords.txt en el directorio de este script."
            echo -e "\n [*] 12. Realizar una fuerza bruta de credenciales de WordPress\n"
            echo -e "USO: Introduce tus listas en los archivos users.txt y passwords.txt en el directorio de este script."
            echo -e "\n [*] 13. Realizar una fuerza bruta de credenciales SQL\n"
            echo -e "USO: Introduce tus listas en los archivos users.txt y passwords.txt en el directorio de este script."
            echo -e "\n [*] 14. Realizar enumeración NFS.\n"
            echo -e "\n [*] 15. Enumerar usuarios SMTP.\n"
            echo -e "\n [*] 16. Enumerar los comandos SMTP disponibles.\n"
            echo -e "\n [*] 17. Realice un escaneo para identificar vulnerabilidades conocidas en SMTP.\n"
            echo -e "\n [*] 18. Enumerar información de SNMP, como interfaces, netstat, procesos, etc.\n"
            echo -e "\n [*] 19. Realizar una fuerza bruta de credenciales SSH.\n"
            echo -e "\n [*] 20. Realizar una fuerza bruta de credenciales de Telnet.\n"
            echo -e "\n [*] 21. Realizar una fuerza bruta de credenciales de MSSQL.\n"
            echo -e "\n [*] 22. Realice una fuerza bruta de credenciales de VNC.\n"
            echo -e "\n [*] 23. Enumerar información general sobre SSL, configuraciones incorrectas y vulnerabilidades.\n"
            echo -e "\n [*] 24. Realizar ataque DDOS.\n"

read -p "¿Qué escaneo quieres realizar?: " opcion

    case $opcion in

                1)nmap -sN $host/24 ;;
                2)nmap -sC -sV -oA $host ;;
                3)nmap -sC -sV -oA $host -top-ports 100  ;;
                4)nmap -sU $host ;;
                5)nmap -O $host ;;
                6)nmap -Pn -script vuln $host ;;
                7)nmap -p 139,445 -script smb-enum* $host ;;
                8)nmap -p 139,445 -script smb-vuln* $host ;;
                9)nmap -p 53 –script dns-zone-transfer.nse –script-args dns-zone-transfer.domain=$dominio ;;
               10)nmap -p 21 –script ftp-brute userdb=users.txt,passdb=passwords.txt $host ;;
               11)nmap -p 80 –script http-form-brute userdb=users.txt,passdb=passwords.txt $host ;;
               12)nmap –p 80 –script http-wordpress-brute –script-args ‘userdb=users.txt,passdb=passwords.txt,http-wordpress-brute.hostname=$dominio, http-wordpress-brute.threads=3,brute.firstonly=true’ $host ;;
               13)nmap -p 80 –script mysql-brute userdb=users.txt,passdb=passwords.txt $host ;;
               14)nmap -p 111 –script nfs* $host ;;
               15)nmap -p 25 –script smtp-enum-users $host ;;
               16)nmap -p 25 –script smtp-commands $host ;;
               17)nmap -p 25 –script smtp-vuln* $host ;;
               18)nmap -sU -p 161 –script snmp* $host ;;
               19)nmap -p 80 –script ssh-brute userdb=users.txt,passdb=passwords.txt $host ;;
               20)nmap -p 80 –script telnet-brute userdb=users.txt,passdb=passwords.txt $host ;;
               21)nmap -p 1433 –script ms-sql-brute –script-args userdb=users.txt,passdb=passwords.txt $host ;;
               22)nmap -p 5900 –script vnc-brute $host ;;
               23)nmap -p 443 –script ssl* $host ;;
               24)nmap -p 80 -max-parallelism 800 -Pn –script http-slowloris –script-args http-slowloris.runforever=true $host ;;
     esac

            echo -e "\n Escaneo Realizado. \n"
