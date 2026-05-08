# Tâche 1 : Gestion de l'affichage VGA

Ce dossier contient les fichiers relatifs à la première étape du projet (Affichage 4 bits et couleurs mouvantes).

L'objectif de cette étape était de faire évoluer le contrôleur VGA de base pour supporter une profondeur de couleur plus importante et une dynamique d'affichage complexe.
- Extension du Bus de Données : Passage d'un codage sur 3 bits (8 couleurs) à un codage sur 12 bits (4096 couleurs), permettant une gestion fine de l'intensité pour chaque canal RGB (4 bits par composante).
- Création de Registres et Compteurs : Implémentation de trois compteurs 5 bits pour piloter les teintes de Rouge, Vert et Bleu indépendamment.
- Machine à États (MAE) : Conception d'une MAE cadencée à 100 MHz pour orchestrer les phases de transition de couleurs (incrémentation/décrémentation des teintes) afin de générer un dégradé dynamique à l'écran.
- Gestion des Signaux de Synchronisation : Adaptation du contrôleur pour maintenir l'intégrité des signaux HSync et VSync tout en synchronisant les nouvelles données de couleurs sur l'horloge pixel de 25 MHz. 

## Points clés :
1- **Simulation** : Un exemple de simulation est disponible pour valider le chronogramme du contrôleur VGA (fichiers de testbench inclus).
2- **Contraintes (.xdc)** : Le fichier de mapping des broches a été nettoyé.
3- **Note technique** : Toutes les broches inutilisées pour cette tâche ont été désactivées en utilisant le caractère `#` (mise en commentaire) pour éviter les conflits lors de l'implémentation sur la carte Basys/Nexys (Basys pour nous).
