# React Project Generator Script

## Description
Un script Bash automatisé pour créer et configurer rapidement des projets React avec Vite. Le script met en place une structure de projet complète avec Tailwind CSS et des bibliothèques essentielles.

## Fonctionnalités

- Création de projet React avec Vite
- Support TypeScript et JavaScript
- Configuration automatique de Tailwind CSS
- Structure de dossiers organisée
- Installation des bibliothèques essentielles
- Configuration environnement (.env)

## Prérequis

- Node.js
- npm ou yarn
- Bash shell

## Installation

1. Téléchargez le script
2. Rendez-le exécutable :
```bash
chmod +x script.sh
```

## Utilisation

1. Exécutez le script :
```bash
./script.sh
```

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
