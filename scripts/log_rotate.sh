#!/bin/bash
# ==========================================================
# Script : log_rotate.sh
# Objectif : Rotation et nettoyage des fichiers logs
# Auteur : SAINT-POL THOMAS 
# Date : 30/10/2025
# ==========================================================

LOG_DIR="$HOME/logs"
LOGFILE="$LOG_DIR/rotation.log"
DAYS=7
SIZE_LIMIT=10000 # Taille en Ko

mkdir -p "$LOG_DIR"

echo "----- Rotation des logs : $(date '+%Y-%m-%d %H:%M:%S') -----" >> "$LOGFILE"

# Suppression des logs vieux de plus de 7 jours
find "$LOG_DIR" -type f -name "*.log" -mtime +$DAYS -exec rm -f {} \; -print >> "$LOGFILE"

# Compression des fichiers trop gros
for file in "$LOG_DIR"/*.log; do
    if [ -f "$file" ]; then
        SIZE=$(du -k "$file" | cut -f1)
        if [ "$SIZE" -gt "$SIZE_LIMIT" ]; then
            gzip "$file"
            echo "Compression : $file (${SIZE}K)" >> "$LOGFILE"
        fi
    fi
done

echo "Rotation terminée." >> "$LOGFILE"
