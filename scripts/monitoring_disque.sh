#!/bin/bash
# ==========================================================
# Script : monitoring_disque.sh
# Objectif : Surveiller l’espace disque, alerter si seuil est au dessus de 80%
# Auteur : SAINT-POL THOMAS 
# Date : 30/10/2025
# ==========================================================

SEUIL=80
LOGFILE="$HOME/logs/monitoring_alerts.log"
mkdir -p "$HOME/logs"

DATE=$(date '+%Y-%m-%d %H:%M:%S')
USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$SEUIL" ]; then
    echo "[$DATE] Alerte : disque à $USAGE% !" | tee -a "$LOGFILE"
else
    echo "[$DATE] Disque OK ($USAGE%)" >> "$LOGFILE"
fi
