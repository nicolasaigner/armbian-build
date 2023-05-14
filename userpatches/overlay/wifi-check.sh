#!/bin/bash

# Verifica se a Orange Pi Zero está conectada a uma rede WiFi
if ! /sbin/iwgetid -r ; then
    # Cria um hotspot
    sudo systemctl start hostapd
    sudo systemctl start dnsmasq
fi
