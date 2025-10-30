#!/usr/bin/env python3
# ==========================================================
# Script : backup.py
# Objectif : Sauvegarder un dossier spécifié vers un répertoire horodaté
# Auteur : SAINT-POL THOMAS
# Date : 30/10/2025
# ==========================================================

import os
import shutil
from datetime import datetime

source = input("Entrez le chemin du dossier à sauvegarder : ")
dest = os.path.expanduser("~/sauvegardes")
log_file = os.path.expanduser("~/logs/backup.log")

os.makedirs(dest, exist_ok=True)
os.makedirs(os.path.dirname(log_file), exist_ok=True)

date = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
backup_folder = os.path.join(dest, f"backup_{date}")

try:
    shutil.copytree(source, backup_folder)
    message = f"[{date}] Sauvegarde réussie : {backup_folder}"
    print(message)
    print("(Simulation) Email envoyé à thomas.saint-pol@epfedu.fr")
except Exception as e:
    message = f"[{date}] Erreur : {str(e)}"
    print(message)

with open(log_file, "a") as log:
    log.write(message + "\n")
