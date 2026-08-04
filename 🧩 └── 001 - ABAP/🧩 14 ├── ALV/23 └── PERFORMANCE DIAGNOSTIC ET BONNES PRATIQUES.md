# 23. PERFORMANCE, DIAGNOSTIC ET BONNES PRATIQUES

## 23.A RÉSULTAT ATTENDU

- Éviter les principaux problèmes de performance
- Diagnostiquer un comportement incorrect
- Appliquer une checklist de livraison

## 23.B PERFORMANCE DES DONNÉES

L’ALV ne corrige pas une sélection inefficace. Avant l’affichage :

- sélectionner uniquement les champs requis ;
- appliquer les filtres dans ABAP SQL ;
- éviter les accès base dans une boucle ;
- limiter les volumes incompatibles avec une utilisation interactive ;
- construire les textes et indicateurs en une phase maîtrisée.

## 23.C PERFORMANCE DU CONTRÔLE

- Créer la grille une seule fois.
- Utiliser `REFRESH_TABLE_DISPLAY` pour les actualisations.
- Éviter un catalogue excessivement dynamique.
- Ne pas recalculer toutes les lignes dans un handler de cellule si seule une ligne est concernée.
- Conserver les références du conteneur, de la grille et des handlers.

## 23.D DIAGNOSTIC

| Symptôme                    | Vérification                                         |
| --------------------------- | ---------------------------------------------------- |
| Grille vide                 | Table interne, PBO, appel initial                    |
| Colonne absente             | `FIELDNAME`, structure, `TECH`, `NO_OUT`             |
| Événement non déclenché     | `SET HANDLER`, durée de vie du receiver              |
| Valeur saisie non récupérée | `REGISTER_EDIT_EVENT`, `CHECK_CHANGED_DATA`          |
| Mise en page perdue         | clé `DISVARIANT`, `I_SAVE`, reconstruction de grille |
| Position perdue             | `LVC_S_STBL`, mode de rafraîchissement               |
| Erreur frontend             | Control Framework, `FLUSH`, dump ou message système  |

## 23.E PROGRAMMES DE DÉMONSTRATION

Selon la version du système, SAP livre des programmes de démonstration ALV, notamment dans les familles `BCALV_*`. Les analyser dans `SE38` ou `SE80` permet d’observer les événements, l’édition et les styles disponibles sur le système réel.

## 23.F CHECKLIST

- [ ] Technologie choisie selon le besoin
- [ ] Structure de sortie dédiée et lisible
- [ ] Devise et unité correctement référencées
- [ ] Autorisations contrôlées dans le backend
- [ ] Gestionnaires d’événements enregistrés une seule fois
- [ ] Modifications transférées avant sauvegarde
- [ ] Sauvegarde transactionnelle explicite
- [ ] Rafraîchissement stable
- [ ] Variantes testées
- [ ] Volume de données maîtrisé
- [ ] Messages issus d’une classe de messages
- [ ] Aucun accès base inutile dans les événements

## 23.G VÉRIFICATION

- Le lecteur peut expliquer la différence entre cette notion et les concepts proches.
- Le choix technique est justifié par un besoin concret, pas uniquement par habitude.
- Les limites liées à la release, aux autorisations et au contexte d’exécution sont identifiées.

## 23.H ERREURS FRÉQUENTES

- Afficher un volume non borné dans l’ALV.
- Rendre une cellule éditable sans validation ni sauvegarde transactionnelle.

## 23.I TERMES DU LEXIQUE

- [ALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-alv>)
- [SALV](<../🧩 00 ├── LEXIQUE SAP ET ABAP/10 └── ACRONYMES SAP.md#acro-salv>)
- [Table interne](<../🧩 00 ├── LEXIQUE SAP ET ABAP/04 ├── LANGAGE ET DEVELOPPEMENT ABAP.md#table-interne>)

## 23.J RÉFÉRENCES OFFICIELLES SAP

- [ABAP List Viewer (ALV) — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694342.html)
- [Methods of Class CL_GUI_ALV_GRID — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/22a3f5ecd2fe11d2b467006094192fe3.html)
- [Demo Program Information in NetWeaver — SAP Help Portal](https://help.sap.com/docs/SUPPORT_CONTENT/nwtech/3362694205.html)
- [refresh_table_display — SAP Help Portal](https://help.sap.com/docs/ABAP_PLATFORM_NEW/70396d7dec4c4f19b9ca3b2e47559d12/0ab5531ed30911d2b467006094192fe3.html)
