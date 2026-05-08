**Tâche 2 : Gestion de la Raquette avec l'Encodeur Rotatif**
L'objectif de cette tâche est de développer une IP (Intellectual Property) permettant d'interpréter les rotations d'un encodeur physique pour piloter les déplacements de la raquette dans le jeu Casse-Briques.
1- Objectifs et Architecture
  Pour répondre au cahier des charges du TP, l'architecture est divisée en deux sous-modules principaux:
- Module Rotary (Filtrage) : Ce bloc récupère les signaux bruts Rot_A et Rot_B issus de l'encodeur. Son rôle est de filtrer les signaux pour éliminer les phénomènes de rebonds mécaniques (anti-rebond).
- Module Move (Logique de Déplacement) : Ce module contient la Machine à États (MAE) que j'ai conçue pour déterminer le sens de rotation.
2- Implémentation de la MAE Move
  La logique repose sur l'analyse du déphasage entre les signaux QA et QB:
  - Détection du Sens : En prenant QA comme référence, le module détermine si QA change d'état avant ou après QB.
  - Génération des Commandes : Si QA est en avance : Rotation à gauche $\rightarrow$ Activation du signal Rot_Left pendant un cycle.  Si QA est en retard : Rotation à droite $\rightarrow$ Activation du signal Rot_Right pendant un cycle.
3- Points clés de réalisation :
  - Intégration Hiérarchique : Le module move.vhd a été instancié au sein de ip_rotary.vhd pour remplacer les signaux forcés à '0' par une logique de contrôle réelle.
  - Validation par Simulation : Utilisation d'un Testbench pour valider que chaque impulsion de l'encodeur génère bien un mouvement d'un seul pixel, évitant ainsi les déplacements non fixes de la raquette.
  - Contraintes Matérielles : Configuration des résistances de Pull-up sur les entrées FPGA pour garantir des niveaux logiques stables lorsque les switchs de l'encodeur sont ouverts.
