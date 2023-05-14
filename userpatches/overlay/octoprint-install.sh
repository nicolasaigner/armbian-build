#!/bin/bash

# Instala dependências
sudo apt-get install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential

# Cria um diretório para o OctoPrint
mkdir OctoPrint && cd OctoPrint

# Cria um ambiente virtual e o ativa
virtualenv venv
source venv/bin/activate

# Instala o OctoPrint no ambiente virtual
pip install OctoPrint

# Adiciona o OctoPrint ao systemd para iniciar na inicialização
echo "
[Unit]
Description=The snappy web interface for your 3D printer
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/home/pi/OctoPrint/venv/bin/octoprint serve
WorkingDirectory=/home/pi/OctoPrint
User=pi
Type=simple
Restart=always
RestartSec=15

[Install]
WantedBy=multi-user.target
" | sudo tee /etc/systemd/system/octoprint.service

# Habilita o serviço do OctoPrint
sudo systemctl enable octoprint
