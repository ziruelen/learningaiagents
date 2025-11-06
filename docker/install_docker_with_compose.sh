#!/bin/bash

set -e

# Actualizar el sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias comunes
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common lsb-release

# Detectar arquitectura
ARCH=$(uname -m)

# Instalar Docker usando el script oficial (compatible con x86 y ARM/Raspberry Pi)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# NO añadimos el usuario al grupo docker, para que sea obligatorio usar sudo

# Instalar Docker Compose según la arquitectura
if [[ "$ARCH" == "x86_64" ]]; then
    # Para x86_64 (PC)
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "armv7l" ]]; then
    # Para Raspberry Pi (ARM)
    sudo apt install -y python3-pip libffi-dev libssl-dev
    sudo pip3 install docker-compose
else
    echo "Arquitectura no soportada: $ARCH"
    exit 1
fi

# Verificar instalaciones
echo "Docker versión:"
sudo docker --version

echo "Docker Compose versión:"
if command -v docker-compose &> /dev/null; then
    sudo docker-compose --version
else
    sudo docker compose version
fi

echo "Instalación completada. Recuerda que debes usar 'sudo' para todos los comandos de Docker."
