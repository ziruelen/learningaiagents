# One-liners SSH Útiles

## Ejecutar Comandos Remotos

\`\`\`bash
# Comando simple
ssh usuario@servidor 'uptime'

# Múltiples comandos
ssh usuario@servidor 'cd /var/www && git pull && npm install'

# Comandos condicionales
ssh usuario@servidor 'mkdir /newdir && cd /newdir'
ssh usuario@servidor 'cd /nonexistent || echo "No existe"'
\`\`\`

## Crear Notas en Servidor Remoto

\`\`\`bash
# Añadir nota con fecha
ssh usuario@servidor "echo 'Nota: $(date)' >> ~/notas.txt"

# Añadir nota con contenido
ssh usuario@servidor "echo 'Backup completado $(date)' >> ~/log.txt"
\`\`\`

## Copiar Output Remoto

\`\`\`bash
# Guardar log remoto localmente
ssh usuario@servidor 'cat /var/log/syslog' > syslog_backup.txt

# Copiar configuración
ssh usuario@servidor 'cat /etc/nginx/nginx.conf' > nginx.conf.backup
\`\`\`

## Ejecutar Script Local en Remoto

\`\`\`bash
# Ejecutar script sin copiarlo
ssh usuario@servidor 'bash -s' < ./deploy.sh

# Con parámetros
ssh usuario@servidor 'bash -s' < ./script.sh arg1 arg2
\`\`\`

## Monitoreo en Tiempo Real

\`\`\`bash
# Tail logs remotos
ssh usuario@servidor 'tail -f /var/log/syslog'

# Monitorear procesos
ssh usuario@servidor 'watch -n 1 "ps aux | grep proceso"'
\`\`\`

## Ejecutar con Sudo

\`\`\`bash
# Comando con sudo
ssh usuario@servidor 'sudo systemctl restart apache2'

# Múltiples comandos con sudo
ssh usuario@servidor 'sudo apt update && sudo apt upgrade -y'
\`\`\`

## Múltiples Servidores

\`\`\`bash
# Loop sobre servidores
for host in servidor1 servidor2 servidor3; do
  ssh usuario@$host 'uptime'
done

# Con IPs
for ip in 192.168.1.10 192.168.1.11 192.168.1.12; do
  ssh usuario@$ip 'df -h'
done
\`\`\`

## Transferir y Ejecutar

\`\`\`bash
# Transferir archivo y ejecutar
scp script.sh usuario@servidor:/tmp/ && ssh usuario@servidor 'bash /tmp/script.sh'

# Transferir, ejecutar y eliminar
scp script.sh usuario@servidor:/tmp/ && \
ssh usuario@servidor 'bash /tmp/script.sh && rm /tmp/script.sh'
\`\`\`

## Comparar Archivos

\`\`\`bash
# Comparar archivos locales y remotos
diff archivo.txt <(ssh usuario@servidor 'cat /ruta/archivo.txt')
\`\`\`

## Ejecutar en Background

\`\`\`bash
# Ejecutar comando en background remoto
ssh usuario@servidor 'nohup comando_largo > output.log 2>&1 &'

# Verificar que está corriendo
ssh usuario@servidor 'ps aux | grep comando_largo'
\`\`\`
