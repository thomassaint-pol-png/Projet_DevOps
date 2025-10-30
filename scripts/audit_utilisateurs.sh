#!/bin/bash
# ==========================================================
# Script : audit_utilisateurs.sh
# Objectif : Lister les connexions actives et alerter si root connecté hors horaires
# Auteur : SAINT-POL THOMAS 
# Date : 30/10/2025
# ==========================================================

LOGFILE="$HOME/logs/audit_users.log"
mkdir -p "$HOME/logs"
DATE=$(date '+%Y-%m-%d %H:%M:%S')
HEURE=$(date '+%H')

echo "----- Audit du $DATE -----" >> "$LOGFILE"

# Liste des utilisateurs connectés
who >> "$LOGFILE"

# Vérification de la connexion root hors horaire
if who | grep -q "root"; then
    if [ "$HEURE" -lt 8 ] || [ "$HEURE" -gt 18 ]; then
        echo "[$DATE] Alerte : root connecté hors plage horaire !" | tee -a "$LOGFILE"
    fi
fi

echo "Audit terminé." >> "$LOGFILE"
