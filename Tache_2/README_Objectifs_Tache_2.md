# Tâche 2 : Gestion de la Raquette avec l'Encodeur Rotatif

L'objectif de cette tâche est de développer une **IP (Intellectual Property)** permettant d'interpréter les rotations d'un encodeur physique pour piloter les déplacements de la raquette dans le jeu Casse-Briques.

---

### 1. Objectifs et Architecture
Pour répondre au cahier des charges du projet, l'architecture est divisée en deux sous-modules principaux :

* **Module `Rotary` (Filtrage)** : Ce bloc récupère les signaux bruts `Rot_A` et `Rot_B` issus de l'encodeur. Son rôle est de filtrer les signaux pour éliminer les phénomènes de rebonds mécaniques (anti-rebond).
* **Module `Move` (Logique de Déplacement)** : Ce module contient la **Machine à États (MAE)** conçue pour déterminer le sens de rotation.

---

### 2. Implémentation de la MAE `Move`
La logique repose sur l'analyse du déphasage entre les signaux `QA` et `QB` :

* **Détection du Sens** : En prenant `QA` comme référence, le module détermine si `QA` change d'état **avant** ou **après** `QB`.
* **Génération des Commandes** : 
    * **Rotation à gauche** : Si `QA` est en avance $\rightarrow$ Activation du signal `Rot_Left` pendant un cycle d'horloge.
    * **Rotation à droite** : Si `QA` est en retard $\rightarrow$ Activation du signal `Rot_Right` pendant un cycle d'horloge.

---

### 3. Points clés de réalisation

* **Intégration Hiérarchique** : Le module `move.vhd` a été instancié au sein de `ip_rotary.vhd` pour remplacer les signaux précédemment forcés à '0' par une logique de contrôle réelle et interactive.
* **Validation par Simulation** : Utilisation d'un **Testbench** pour valider que chaque impulsion de l'encodeur génère bien un mouvement précis d'un seul pixel, garantissant la stabilité des déplacements de la raquette.
* **Contraintes Matérielles** : Configuration des résistances de **Pull-up** sur les entrées FPGA via le fichier `.xdc` pour garantir des niveaux logiques stables lorsque les interrupteurs de l'encodeur sont ouverts.
