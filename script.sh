#!/bin/bash

# Demander le nom du projet
read -p "🛠️  Nom du projet : " PROJECT_NAME

# Vérifier si le projet existe déjà
if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  Le projet '$PROJECT_NAME' existe déjà."
    read -p "Souhaitez-vous ajouter la structure des dossiers manquants ? (y/n) " ADD_STRUCTURE
    read -p "Voulez-vous installer Tailwind et les bibliothèques recommandées ? (y/n) " ADD_LIBS
else
    # Choisir entre TypeScript et JavaScript
    echo "📌 Choisissez le type de projet React :"
    options=("TypeScript (react-ts)" "JavaScript (react)")
    select opt in "${options[@]}"; do
        case $opt in
            "TypeScript (react-ts)")
                TEMPLATE="react-ts"
                FILE_EXT="tsx"
                break
                ;;
            "JavaScript (react)")
                TEMPLATE="react"
                FILE_EXT="jsx"
                break
                ;;
            *) echo "❌ Option invalide, choisissez 1 ou 2.";;
        esac
    done

    # Choisir entre Yarn et NPM
    echo "📌 Choisissez le gestionnaire de paquets :"
    options=("Yarn" "NPM")
    select opt in "${options[@]}"; do
        case $opt in
            "Yarn")
                PKG_MANAGER="yarn"
                break
                ;;
            "NPM")
                PKG_MANAGER="npm"
                break
                ;;
            *) echo "❌ Option invalide, choisissez 1 ou 2.";;
        esac
    done

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
cd $PROJECT_NAME

# Ajouter la structure des dossiers
if [[ "$ADD_STRUCTURE" == "y" ]]; then
    echo "📂 Création de la structure des dossiers..."
    mkdir -p src/{assets,components,hooks,layouts,pages,services,store,utils}

    # Création des fichiers essentiels
    touch src/components/{NavBar.$FILE_EXT,SideBar.$FILE_EXT}
    touch src/pages/{Home.$FILE_EXT,Login.$FILE_EXT,Register.$FILE_EXT}
fi

# Installer Tailwind et les bibliothèques recommandées
if [[ "$ADD_LIBS" == "y" ]]; then
    echo "📦 Installation de Tailwind et des bibliothèques..."
    $PKG_MANAGER add react-router-dom react-icons @mui/material @mui/icons-material react-hot-toast tailwindcss @tailwindcss/vite
    $PKG_MANAGER add -D tailwindcss postcss autoprefixer

    # Générer les fichiers de config Tailwind si absent
    if [ ! -f "tailwind.config.js" ]; then
        npx tailwindcss init -p
    fi

    # Vérifier si Tailwind est déjà ajouté dans index.css, sinon l'ajouter
    if ! grep -q "@tailwind base;" src/index.css 2>/dev/null; then
        echo "🔧 Ajout de Tailwind dans index.css..."
        echo -e "@tailwind base;\n@tailwind components;\n@tailwind utilities;\n$(cat src/index.css)" > src/index.css
    fi
fi

# Ajouter un fichier .env si absent
if [ ! -f ".env" ]; then
    echo "🔑 Création du fichier .env..."
    echo "VITE_API_URL='http://localhost:8000'" > .env
fi

# Exécuter l'installation finale
$PKG_MANAGER install

# Fin du script
echo "✅ Projet '$PROJECT_NAME' prêt à l'emploi !"
echo "🚀 Démarrez avec : cd $PROJECT_NAME && $PKG_MANAGER dev"
