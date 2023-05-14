#!/bin/bash

# Atualizar o sistema
apt-get update
apt-get upgrade -y

# Instalar dependências necessárias para o OctoPrint
apt-get install -y python3-pip python3-dev python3-setuptools python3-virtualenv python3-numpy
apt-get install -y libyaml-dev build-essential

# Crie um usuário para executar o OctoPrint
useradd -m -G dialout,tty octoprint 

# Instale o OctoPrint
su - octoprint -c "virtualenv venv"
su - octoprint -c "source venv/bin/activate"
su - octoprint -c "pip install OctoPrint"

# Crie um serviço systemd para iniciar o OctoPrint na inicialização
cat > /etc/systemd/system/octoprint.service << EOF
[Unit]
Description=OctoPrint

[Service]
User=octoprint
ExecStart=/home/octoprint/venv/bin/octoprint serve

[Install]
WantedBy=multi-user.target
EOF

# Ative o serviço
systemctl enable octoprint

# Copie os scripts personalizados para os locais apropriados
cp ./userpatches/overlay/wifi-check.sh /etc/init.d/
cp ./userpatches/overlay/octoprint-install.sh /usr/local/bin/

# Dê a eles permissões de execução
chmod +x /etc/init.d/wifi-check.sh
chmod +x /usr/local/bin/octoprint-install.sh
