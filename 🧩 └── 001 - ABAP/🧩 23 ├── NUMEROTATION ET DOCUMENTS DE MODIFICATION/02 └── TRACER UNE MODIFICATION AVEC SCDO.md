# TRACER UNE MODIFICATION AVEC SCDO

## RÉSULTAT ATTENDU

Créer un document de modification lors d’un changement sur un objet métier client.

## PROCÉDURE RAPIDE

1. Activer la journalisation des champs nécessaires dans leurs éléments de données.
2. Créer l’objet `Z...` dans `SCDO` et déclarer les tables concernées.
3. Générer les modules de mise à jour.
4. Appeler le module `..._WRITE_DOCUMENT` généré après la modification métier.
5. Contrôler les en-têtes et positions de documents de modification avec les outils standard appropriés.

## CODE

La signature du module est générée à partir de l’objet SCDO. Ne pas recopier une signature générique : insérer le modèle du module généré depuis l’éditeur ABAP et renseigner explicitement les images ancienne et nouvelle.

## CONTRÔLE

- Une modification effective crée une entrée.
- Une sauvegarde sans changement ne doit pas produire artificiellement un document.
