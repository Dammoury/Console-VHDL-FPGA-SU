# Console-VHDL-FPGA-SU

Conception d'une console de jeux sur FPGA (Basys/Nexys) en VHDL dans le cadre du module de 3ème année de Licence à Sorbonne Université.

**Ce dépôt contient le code VHDL de la console SU-EE100.**

---

### Points Clés du Projet
* Implémentation d'un contrôleur VGA 4 bits (4096 couleurs).
* Gestion d'un encodeur rotatif par machine à états (MAE).
* Implémentation de la logique de jeu complète (Casse-Briques) avec gestion des collisions, timers et conditions de fin de partie.

---

### Structure du Développement
Le projet a été mené de manière modulaire, divisé en 3 tâches principales :

1. **Tâche 1 : Affichage VGA** Amélioration du contrôleur graphique pour supporter des couleurs sur 12 bits et génération de dégradés dynamiques.
2. **Tâche 2 : Encodeur Rotatif** Création d'une IP dédiée avec filtre anti-rebond et MAE (move.vhd) pour le contrôle matériel du déplacement de la raquette.
3. **Tâche 3 : Logique de Jeu et Décor** Implémentation des états du jeu (Pause, Victoire, Défaite) et intégration d'un **obstacle mobile** au sein du module decor.vhd pour complexifier la partie.

---

### Fonctionnalités de la Console
Suite à l'implémentation de ces modules, le jeu final est pleinement fonctionnel et propose :
* **Multi-cartes** : Le code est adapté et déployable sur les cartes FPGA Basys et Nexys via la sélection des fichiers de contraintes appropriés.
* **Sélection des contrôles** : La raquette peut être pilotée avec précision soit via l'encodeur rotatif, soit via l'accéléromètre embarqué.
* **Retours visuels interactifs** : L'écran devient rouge en cas de défaite (balle perdue) et vert en cas de victoire (toutes les briques détruites).

---

### Modules Principaux
L'architecture matérielle s'articule autour de ces composants clés :
* VGA_4bits.vhd / Moving_Colors.vhd : Gestion de l'affichage et synchronisation vidéo.
* ip_rotary.vhd / move.vhd : Traitement physique des entrées utilisateur.
* game.vhd / mode.vhd / decor.vhd : Cœur algorithmique gérant les règles du Casse-Briques, les timers, et la génération de l'environnement (briques, murs, obstacle mobile).
