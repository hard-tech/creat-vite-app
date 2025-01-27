#!/bin/bash

# Demander le nom du projet
read -p "🛠️  Nom du projet : " PROJECT_NAME

# Choisir entre Yarn et NPM
    echo "📌 Choisissez le gestionnaire de paquets :"
    options=("Yarn" "NPM")
    select opt in "${options[@]}"; do
        case $opt in
            "Yarn")
                PKG_MANAGER="yarn"
                PKG_MANAGER_CMD="yarn"
                break
                ;;
            "NPM")
                PKG_MANAGER="npm"
                PKG_MANAGER_CMD="npm run"
                break
                ;;
            *) echo "❌ Option invalide, choisissez 1 ou 2.";;
        esac
    done

        # Choisir entre TypeScript et JavaScript
    echo "📌 Choisissez le type de projet React :"
    options=("TypeScript (react-ts)" "JavaScript (react)")
    select opt in "${options[@]}"; do
        case $opt in
            "TypeScript (react-ts)")
                TEMPLATE="react-ts"
                FILE_EXT="tsx"
                CONFIG_EXT="ts"
                break
                ;;
            "JavaScript (react)")
                TEMPLATE="react"
                FILE_EXT="jsx"
                CONFIG_EXT="js"
                break
                ;;
            *) echo "❌ Option invalide, choisissez 1 ou 2.";;
        esac
    done

# Vérifier si le projet existe déjà
if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  Le projet '$PROJECT_NAME' existe déjà."
    read -p "Souhaitez-vous ajouter la structure des dossiers manquants ? (y/n) " ADD_STRUCTURE
    read -p "Voulez-vous installer Tailwind et les bibliothèques recommandées ? (y/n) " ADD_LIBS
else

    # Créer le projet avec Vite
    echo "🚀 Création du projet avec Vite..."
    $PKG_MANAGER create vite $PROJECT_NAME --template $TEMPLATE

    # Vérifier si le projet a bien été créé
    if [ ! -d "$PROJECT_NAME" ]; then
        echo "❌ Erreur : La création du projet a échoué."
        exit 1
    fi

    ADD_STRUCTURE="y"
    ADD_LIBS="y"
fi

# Aller dans le dossier du projet
cd "$PROJECT_NAME"

# Ajouter la structure des dossiers
if [[ "$ADD_STRUCTURE" == "y" ]]; then
    echo "📂 Création de la structure des dossiers..."
    mkdir -p src/{assets,components,hooks,layouts,pages,services,store,utils}

    # Création des fichiers essentiels uniquement s'ils n'existent pas
    touch src/components/{NavBar.$FILE_EXT,SideBar.$FILE_EXT}
    touch src/pages/{Home.$FILE_EXT,Login.$FILE_EXT,Register.$FILE_EXT}
fi

# Installer Tailwind et les bibliothèques recommandées
if [[ "$ADD_LIBS" == "y" ]]; then

    echo "📦 Installation de Tailwind et des bibliothèques..."
    $PKG_MANAGER add react-router-dom react-icons @mui/material @mui/icons-material react-hot-toast tailwindcss @tailwindcss/vite
    $PKG_MANAGER add -D tailwindcss postcss autoprefixer

    # Générer les fichiers de config Tailwind si absent
    # Modifie mon fichier "vite.config.ts" pour ajouter le plugin "vite-plugin-windicss"
    ## Ajout du plugin WindiCSS (tailwindcss())
    echo "import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// https://vite.dev/config/
export default defineConfig({
plugins: [
    react(),
    tailwindcss()
],
})" > ./vite.config.$CONFIG_EXT

    # Modifier le fichier index.css pour importer Tailwind
    ## Ajout de la ligne "@import "tailwindcss";" tout en haut du fichier index.css
    echo "@import 'tailwindcss';" > src/index.css

fi  # <-- Ajout de la fermeture du bloc if

# Ajouter un fichier .env si absent
if [ ! -f ".env" ]; then
    echo "🔑 Création du fichier .env..."
    echo "VITE_API_URL='http://localhost:8000'" > .env
fi

# Exécuter l'installation finale
$PKG_MANAGER install

# Fin du script
echo ""
echo ""
echo "✅ Projet '$PROJECT_NAME' prêt à l'emploi !"
echo ""
echo "🚀 Démarrez avec : cd $PROJECT_NAME && $PKG_MANAGER_CMD dev"
echo ""
echo ""
