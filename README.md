# React Project Generator Script

## Description
Un script Bash automatisé pour créer et configurer rapidement des projets React avec Vite. Le script met en place une structure de projet complète avec Tailwind CSS et des bibliothèques essentielles.

## Installation Rapide

Exécutez cette commande dans votre terminal :
```bash
bash <(curl -Ls https://raw.githubusercontent.com/hard-tech/creat-vite-app/main/script.sh)
```

## Installation Alternative

1. Téléchargez le script
2. Rendez-le exécutable :
```bash
chmod +x script.sh
```

## Prérequis

- Node.js
- npm ou yarn
- Bash shell

## Utilisation

1. Exécutez le script via la commande d'installation rapide ou directement
2. Suivez les étapes interactives :
- Entrez le nom du projet
- Choisissez TypeScript ou JavaScript
- Sélectionnez npm ou yarn

## Structure du Projet

```
project-name/
├── src/
│   ├── assets/
│   ├── components/
│   │   ├── NavBar.[tsx/jsx]
│   │   └── SideBar.[tsx/jsx]
│   ├── hooks/
│   ├── layouts/
│   ├── pages/
│   │   ├── Home.[tsx/jsx]
│   │   ├── Login.[tsx/jsx]
│   │   └── Register.[tsx/jsx]
│   ├── services/
│   ├── store/
│   └── utils/
├── .env
└── vite.config.[ts/js]
```

## Bibliothèques Installées

- react-router-dom
- react-icons
- @mui/material
- @mui/icons-material
- react-hot-toast
- tailwindcss
- postcss
- autoprefixer

## Démarrage

Après l'installation, démarrez votre projet :
```bash
cd nom-du-projet
npm dev # ou yarn dev
```
