# Tâche 3 : Logique de Jeu et Gestion des Modes

L'objectif de cette tâche est de finaliser l'aspect interactif de la console en implémentant une machine à états capable de gérer les différentes phases du jeu ainsi que les conditions de victoire ou de défaite.

---

### 1. Objectifs et Architecture
Cette étape repose sur la centralisation des informations provenant des différents modules (VGA, IP Rotary) pour orchestrer le fonctionnement global du système :

* **Module Mode (Contrôle)** : Point central de la logique du projet. Il reçoit les signaux de commande (bouton Pause) et les événements du jeu (perte de vie, destruction de briques).
* **Module Game (Intégration)** : Mise à jour de l'entité globale du jeu pour lier les nouvelles fonctionnalités de contrôle à l'affichage et aux déplacements.

---

### 2. Implémentation de la MAE et des Timers
La gestion du déroulement du jeu s'appuie sur une Machine à États (MAE) complexe et l'utilisation de temporisateurs :

* **Machine à États (MAE)** : Configuration des états principaux (Start, Play, Pause, Game Over, Win). La MAE assure des transitions fluides, notamment pour figer le jeu lors de l'appui sur le bouton de pause.
* **Configuration des Timers** : Implémentation de compteurs de temps pour gérer les délais d'affichage (affichage temporaire des messages) et la cadence de mise à jour des éléments mobiles du jeu.
* **Synchronisation** : Asservissement de la logique de jeu sur l'horloge système tout en garantissant la cohérence des données envoyées au contrôleur VGA.

---

### 3. Points clés de réalisation

* **Modification du code VHDL (Game)** : Refonte des processus dans le module `game` pour intégrer les signaux de contrôle issus de la MAE. Remplacement des valeurs statiques par des signaux dynamiques pour permettre l'arrêt et la reprise du jeu.
* **Logique de Victoire et Défaite** : Configuration des comparateurs permettant de détecter la destruction de la dernière brique (victoire) ou le passage de la balle sous la raquette (défaite).
* **Robustesse du Système** : Validation de la stabilité de la MAE lors des changements d'états rapides pour éviter tout blocage du système (deadlock) ou comportement indéterminé sur le FPGA.
